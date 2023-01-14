//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewModel {
    var mode: TabBarMode = .productLists
    var store = MockEntityData.stores().first!
    var detailReviews = MockEntityData.detailReviews()
    var totalVoteCount = 5
    var tagReviews = MockEntityData.tagReviews()

    private let fetchProductListUseCase: FetchProductListUseCaseInterface
    private(set) var categories = [ProductCategory]()
    private(set) var currentCategoryFilter = ProductCategory.all
    var filteredProducts: [Product] {
        let filtered = products.filter({
            if currentCategoryFilter == ProductCategory.all {
                return true
            } else {
                return $0.category == currentCategoryFilter
            }
        })
        return filtered
    }

    var operationInfos = MockEntityData.operations()
    var products: [Product] = MockEntityData.products()

    var operationInfoSeeMoreIndexPaths = Set<IndexPath>()
    private var productListLoadTask: Cancellable?

    init(fetchProductListUseCase: FetchProductListUseCaseInterface) {
        self.fetchProductListUseCase = fetchProductListUseCase
        products.forEach {
            if !categories.contains($0.category) {
                categories.append($0.category)
            }
        }
    }

    func categoryButtonDidTapped(category: ProductCategory?) {
        guard let category = category else { return }
        currentCategoryFilter = category
    }

    private func fetchProductList(storeId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
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

    private func cancelFetchingProductList() {
        productListLoadTask?.cancel()
    }
}

// MARK: - Enums
extension StoreDetailViewModel {
    enum TabBarMode {
        case productLists
        case reviews
        case operationInfo

        var name: String {
            switch self {
            case .productLists:
                return "판매상품"
            case .reviews:
                return "리뷰"
            case .operationInfo:
                return "운영정보"
            }
        }
    }

    enum StoreInfoButtonType {
        case phone
        case link
        case like

        var image: UIImage? {
            switch self {
            case .phone:
                return UIImage(systemName: "phone")
            case .link:
                return UIImage(systemName: "link")
            case .like:
                return UIImage(systemName: "hand.thumbsup")
            }
        }

        var title: String {
            switch self {
            case .phone:
                return "전화"
            case .link:
                return "매장"
            case .like:
                return "추천"
            }
        }
    }
}
