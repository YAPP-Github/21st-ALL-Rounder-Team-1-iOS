//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import Foundation

final class ProductListViewModel {

    let fetchProductListUseCase: FetchProductListUseCaseInterface
    var products: [Product] = [
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸")),
        .init(name: "티트리 퓨리파잉 샴푸", brand: "아로마티카", measurement: "g", price: 100, imageURL: "", category: .init(title: "샴푸"))
    ]

    private var productListLoadTask: Cancellable?

    init(fetchProductListUseCase: FetchProductListUseCaseInterface) {
        self.fetchProductListUseCase = fetchProductListUseCase
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
