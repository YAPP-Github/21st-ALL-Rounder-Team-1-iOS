//
//  RegisterReviewCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class RegisterReviewCoordinator: Coordinator {
    var DIContainer: RegisterReviewDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: RegisterReviewDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        let registerReviewViewController = DIContainer.makeRegisterReviewViewController()
        registerReviewViewController.coordinator = self
        navigationController.pushViewController(registerReviewViewController, animated: true)
    }

    func registerReviewSucceded(userLevel: UserLevelInfo.Level?) {
        if let userLevel = userLevel {
            let registerReviewPopUpViewController = DIContainer.makeRegisterReviewPopUpViewController(
                userLevel: userLevel
            )
            registerReviewPopUpViewController.coordinator = self
            navigationController.present(registerReviewPopUpViewController, animated: true)
        } else {
            navigationController.popViewController(animated: true)
        }
    }

    func popUpDismissed() {
        navigationController.popViewController(animated: true)
    }

    func learnMoreButtonTapped(userLevel: UserLevelInfo.Level) {
        navigationController.popViewController(animated: false)
        let userLevelViewController = DIContainer.makeUserLevelViewController(userLevel: userLevel)
        navigationController.pushViewController(userLevelViewController, animated: true)
    }
}
