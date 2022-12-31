//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import Foundation

final class ProductListViewModel {

    let fetchProductListUseCase: FetchProductListUseCaseInterface
    var currentCategoryFilters = Set<ProductCategory>()
    var filteredProducts: [Product] {
        let filtered = products.filter({
            if currentCategoryFilters == [ProductCategory.all] {
                return true
            } else {
                return currentCategoryFilters.contains($0.category)
            }
        })
        return filtered
    }
    var products: [Product] = [
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "콜라")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "치킨")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "피자")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "리필하는 물건")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "긴거긴거긴거긴거긴거")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "뭔가 되게 멋진 카테고리"))
    ]

    private var productListLoadTask: Cancellable?

    init(fetchProductListUseCase: FetchProductListUseCaseInterface) {
        self.fetchProductListUseCase = fetchProductListUseCase
    }

    func categoryButtonDidTapped(category: ProductCategory?) {
        guard let category = category else { return }

        if currentCategoryFilters.contains(category) { // deselect된 경우
            currentCategoryFilters.remove(category)
            return
        }

        if category == ProductCategory.all {
            currentCategoryFilters.removeAll() // "전체"가 선택된 경우 나머지를 모두 리스트에서 삭제
        } else {
            currentCategoryFilters.remove(ProductCategory.all) // "전체" 말고 다른것이 선택된 경우, "전체"를 리스트에서 삭제
        }

        currentCategoryFilters.insert(category) // 리스트에 선택된 category 삽입
    }

    func fetchProductList(storeId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        productListLoadTask = fetchProductListUseCase
            .execute(requestValue: FetchProductListRequestValue(storeId: storeId)) { result in
                switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func cancelFetchingProductList() {
        productListLoadTask?.cancel()
    }
}
