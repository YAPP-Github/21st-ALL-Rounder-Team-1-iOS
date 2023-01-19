//
//  OnboardingSceneCoordinatorDelegate.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation
import UIKit

final class OnboardingCoordinator: Coordinator {
    var DIContainer: OnboardingDIContainer
    var navigationController: UINavigationController
    var viewController: UIViewController

    init(
        DIContainer: OnboardingDIContainer,
        navigationController: UINavigationController,
        viewController: UIViewController
    ) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        showOnboarding()
    }

    func showOnboarding() {
        viewController = DIContainer.makeOnboardingViewController()
    }

    func showLogin() {

    }

    func showLocationAuthorization() {

    }

    func agreeAndStartButtonTapped() {
        let tabBarDIContainer = DIContainer.makeTabBarDIContainer()
        let tabBarCoordinator = tabBarDIContainer.makeTabBarCoordinator()
        tabBarCoordinator.start()
    }
}
