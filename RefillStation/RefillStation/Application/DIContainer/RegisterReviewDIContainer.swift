//
//  RegisterReviewDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class RegisterReviewDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func makeHomeCoordinator() -> RegisterReviewCoordinator {
        return RegisterReviewCoordinator(DIContainer: self,
                                         navigationController: navigationController)
    }

    // MARK: - Home
    func makeRegisterReviewViewController() {
    }

    func makeRegisterReviewViewModel() {
    }

    func makeUseCase() {

    }

    func makeRegisterReviewRepository() {
    }
}
