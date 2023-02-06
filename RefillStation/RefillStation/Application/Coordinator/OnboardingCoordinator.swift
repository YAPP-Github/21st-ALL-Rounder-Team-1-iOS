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
        let onboardingViewController = DIContainer.makeOnboardingViewController()
        onboardingViewController.coordinator = self
        window?.rootViewController = onboardingViewController
    }

    func showLogin() {
        let loginViewController = DIContainer.makeLoginViewController()
        loginViewController.coordinator = self
        window?.rootViewController = loginViewController
    }

    func showTermsPermission() {
        let termsPermissionViewController = DIContainer.makeTermsPermissionViewController()
        termsPermissionViewController.coordinator = self
        window?.rootViewController = navigationController
        navigationController.pushViewController(termsPermissionViewController, animated: true)
    }

    func showTermsPermissionDetail(termsType: TermsType) {
        let termsDetailViewController = DIContainer.makeTermsDetailViewController(termsType: termsType)
        navigationController.pushViewController(termsDetailViewController, animated: true)
    }

    func showLocationAuthorization(requestValue: SignUpRequestValue) {
        let locationPermissionViewController = DIContainer.makeLocationPermissionViewController(requestValue: requestValue)
        locationPermissionViewController.coordinator = self
        navigationController.pushViewController(locationPermissionViewController, animated: true)
    }

    func agreeAndStartButtonTapped() {
        let tabBarDIContainer = DIContainer.makeTabBarDIContainer()
        let tabBarCoordinator = tabBarDIContainer.makeTabBarCoordinator()
        tabBarCoordinator.start()
    }
}
