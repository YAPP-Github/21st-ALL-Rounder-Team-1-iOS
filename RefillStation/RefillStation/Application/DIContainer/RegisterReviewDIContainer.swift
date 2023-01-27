//
//  RegisterReviewDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class RegisterReviewDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService.shared
    private let storeName: String
    private let storeLocationInfo: String

    init(
        navigationController: UINavigationController,
        storeName: String,
        storeLocationInfo: String
    ) {
        self.navigationController = navigationController
        self.storeName = storeName
        self.storeLocationInfo = storeLocationInfo
    }

    // MARK: - Coordinator
    func makeRegisterReviewCoordinator() -> RegisterReviewCoordinator {
        return RegisterReviewCoordinator(DIContainer: self,
                                         navigationController: navigationController)
    }

    // MARK: - Register Review
    func makeRegisterReviewViewController() -> RegisterReviewViewController {
        return RegisterReviewViewController(viewModel: makeRegisterReviewViewModel())
    }

    func makeRegisterReviewViewModel() -> DefaultTagReviewViewModel {
        return DefaultTagReviewViewModel(storeName: storeName, storeLocationInfo: storeLocationInfo)
    }

    func makeUseCase() {

    }

    func makeRegisterReviewRepository() {

    }
}
