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
    var window: UIWindow?

    init(
        DIContainer: OnboardingDIContainer,
        navigationController: UINavigationController,
        window: UIWindow?
    ) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        showOnboarding()
    }

    func showOnboarding() {
        window?.rootViewController = DIContainer.makeOnboardingViewController()
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
