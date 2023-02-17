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
    var navigationController: UINavigationController = UINavigationController()

    init(
        DIContainer: OnboardingDIContainer
    ) {
        self.DIContainer = DIContainer
    }

    func start() {
        showOnboarding()
    }

    func showOnboarding() {
        let onboardingViewController = DIContainer.makeOnboardingViewController()
        onboardingViewController.coordinator = self
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        window?.rootViewController = onboardingViewController
    }

    func showLogin(viewType: LoginViewController.ViewType) {
        let loginViewController = DIContainer.makeLoginViewController(viewType: viewType)
        loginViewController.coordinator = self
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window

        if viewType == .onboarding {
            navigationController.modalPresentationStyle = .fullScreen
            window?.rootViewController = navigationController
            navigationController.pushViewController(loginViewController, animated: false)
        } else {
            navigationController.modalPresentationStyle = .fullScreen
            window?.rootViewController?.present(navigationController, animated: true)
            navigationController.pushViewController(loginViewController, animated: false)
        }
    }

    func showTermsPermission(requestValue: SignUpRequestValue) {
        let termsPermissionViewController = DIContainer.makeTermsPermissionViewController(requestValue: requestValue)
        termsPermissionViewController.coordinator = self
        navigationController.pushViewController(termsPermissionViewController, animated: true)
    }

    func showTermsPermissionDetail(termsType: TermsType) {
        let termsDetailViewController = DIContainer.makeTermsDetailViewController(termsType: termsType)
        navigationController.pushViewController(termsDetailViewController, animated: true)
    }

    func showLocationAuthorization(requestValue: SignUpRequestValue) {
        let locationPermissionViewController = DIContainer.makeLocationPermissionViewController(
            requestValue: requestValue
        )
        locationPermissionViewController.coordinator = self
        if KeychainManager.shared.getItem(key: "token") == nil
        && !UserDefaults.standard.bool(forKey: "didLookAroundLoginStarted") {
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            window?.rootViewController = navigationController
            navigationController.pushViewController(locationPermissionViewController, animated: true)
        } else {
            navigationController.pushViewController(locationPermissionViewController, animated: true)
        }
    }

    func agreeAndStartButtonTapped() {
        if UserDefaults.standard.bool(forKey: "didLookAroundLoginStarted") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController.dismiss(animated: true)
            }
            UserDefaults.standard.set(false, forKey: "isLookAroundUser")
        } else {
            let tabBarDIContainer = DIContainer.makeTabBarDIContainer()
            let tabBarCoordinator = tabBarDIContainer.makeTabBarCoordinator()
            tabBarCoordinator.start()
        }
        UserDefaults.standard.set(false, forKey: "didLookAroundLoginStarted")
    }
}
