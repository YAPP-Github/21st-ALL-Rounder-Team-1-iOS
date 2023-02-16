//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

protocol Coordinator: AnyObject {
    associatedtype DIContainerProtocol: DIContainer
    var DIContainer: DIContainerProtocol { get }

    func start()
}

extension Coordinator {
    func showLoginPage() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let navigationController = UINavigationController()
        let onboardingDIContainer = OnboardingDIContainer(navigationController: navigationController,
                                                          window: appDelegate.window)
        let onboardingCoordinator = onboardingDIContainer.makeOnboardingCoordinator()
        let loginViewController = onboardingDIContainer.makeLoginViewController()
        loginViewController.coordinator = onboardingCoordinator
        appDelegate.window?.rootViewController = loginViewController
    }
}
