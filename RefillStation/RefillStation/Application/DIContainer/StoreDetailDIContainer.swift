//
//  StoreDetailDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class StoreDetailDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService()
    private let store: Store

    init(navigationController: UINavigationController, store: Store) {
        self.navigationController = navigationController
        self.store = store
    }

    // MARK: - RegisterReview
    func makeRegisterReviewDIContainer() -> RegisterReviewDIContainer {
        return RegisterReviewDIContainer(
            navigationController: navigationController,
            storeName: store.name,
            storeLocationInfo: store.address
        )
    }

    // MARK: - Coordinator
    func makeStoreDetailCoordinator() -> StoreDetailCoordinator {
        return StoreDetailCoordinator(DIContainer: self,
                                      navigationController: navigationController)
    }

    // MARK: - Store Detail
    func makeStoreDetailViewController() -> StoreDetailViewController {
        return StoreDetailViewController(viewModel: makeStoreDetailViewModel())
    }

    func makeStoreDetailViewModel() -> StoreDetailViewModel {
        return StoreDetailViewModel(
            store: store,
            fetchProductListUseCase: makeFetchProductListUseCase()
        )
    }

    func makeFetchProductListUseCase() -> FetchProductListUseCase {
        return FetchProductListUseCase(productListRepository: makeProductListRepository())
    }

    func makeProductListRepository() -> ProductListRepository {
        return ProductListRepository(networkService: networkService)
    }

    // MARK: - Detail Photo Review
    func makeDetailPhotoReviewViewModel(photoURLs: [String?]) -> DetailPhotoReviewViewModel {
        return DetailPhotoReviewViewModel(photoURLs: photoURLs)
    }

    func makeDetailPhotoReviewViewController(photoURLs: [String?]) -> DetailPhotoReviewViewController {
        return DetailPhotoReviewViewController(viewModel: makeDetailPhotoReviewViewModel(photoURLs: photoURLs))
    }
}
