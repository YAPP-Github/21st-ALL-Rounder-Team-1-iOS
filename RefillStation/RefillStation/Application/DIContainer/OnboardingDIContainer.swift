//
//  OnboardingDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class OnboardingDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let viewController: UIViewController

    init(
        navigationController: UINavigationController,
        viewController: UIViewController
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    // MARK: - TabBarDIContainer
    func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer()
    }

    // MARK: - Coordinator
    func makeOnboardingCoordinator() -> OnboardingCoordinator {
        return OnboardingCoordinator(DIContainer: self,
                                     navigationController: navigationController,
                                     viewController: viewController)
    }

    // MARK: - Onboarding
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(viewModel: makeOnboardingViewModel())
    }

    func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }

    // MARK: - Login
    func makeLoginViewController() {

    }

    func makeLoginViewModel() {

    }

    // MARK: - Terms Permission
    func makeTermsPermissionViewController() {

    }

    func makeTermsPermissionViewModel() {

    }

    // MARK: - Terms Detail
    func makeTermsDetailViewController() {

    }

    func makeTermsDetailViewModel() {

    }

    // MARK: - Nickname
    func makeNicknameViewController() {

    }

    func makeNicknameViewModel() {

    }

    // MARK: - Location Permission
    func makeLocationPermissionViewController() {

    }
}
