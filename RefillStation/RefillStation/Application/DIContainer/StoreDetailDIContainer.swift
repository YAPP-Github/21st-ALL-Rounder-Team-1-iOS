//
//  StoreDetailDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class StoreDetailDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let onboardingNavigationController = UINavigationController()
    private let store: Store

    init(navigationController: UINavigationController, store: Store) {
        self.navigationController = navigationController
        self.store = store
    }

    // MARK: - RegisterReview
    func makeRegisterReviewDIContainer() -> RegisterReviewDIContainer {
        return RegisterReviewDIContainer(
            navigationController: navigationController,
            storeId: store.storeId,
            storeName: store.name,
            storeLocationInfo: store.address
        )
    }

    // MARK: - Onboarding
    func makeOnboardingDIContainer() -> OnboardingDIContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        return OnboardingDIContainer(navigationController: onboardingNavigationController,
                                     window: appDelegate.window)
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
            fetchProductsUseCase: makeFetchProductsUseCase()
        )
    }

    func makeFetchProductsUseCase() -> FetchProductsUseCase {
        return FetchProductsUseCase()
    }

    // MARK: - Detail Photo Review
    func makeDetailPhotoReviewViewModel(photoURLs: [String?]) -> DetailPhotoReviewViewModel {
        return DetailPhotoReviewViewModel(photoURLs: photoURLs)
    }

    func makeDetailPhotoReviewViewController(photoURLs: [String?]) -> DetailPhotoReviewViewController {
        return DetailPhotoReviewViewController(viewModel: makeDetailPhotoReviewViewModel(photoURLs: photoURLs))
    }
}
