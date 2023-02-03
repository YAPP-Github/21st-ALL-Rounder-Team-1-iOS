//
//  OnboardingDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class OnboardingDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let window: UIWindow?

    init(
        navigationController: UINavigationController,
        window: UIWindow?
    ) {
        self.navigationController = navigationController
        self.window = window
    }

    // MARK: - TabBarDIContainer
    func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer(window: window)
    }

    // MARK: - Coordinator
    func makeOnboardingCoordinator() -> OnboardingCoordinator {
        return OnboardingCoordinator(DIContainer: self,
                                     navigationController: navigationController,
                                     window: window)
    }

    // MARK: - Onboarding
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(viewModel: makeOnboardingViewModel())
    }

    func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }

    // MARK: - Login
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController()
    }

    // MARK: - Terms Permission
    func makeTermsPermissionViewController() -> TermsPermissionViewController {
        let viewController = TermsPermissionViewController(viewModel: makeTermsPermissionViewModel())
        return viewController
    }

    func makeTermsPermissionViewModel() -> TermsPermissionViewModel {
        return TermsPermissionViewModel()
    }

    // MARK: - Terms Detail
    func makeTermsDetailViewController(termsType: TermsType) -> TermsDetailViewController {
        return TermsDetailViewController(termsType: termsType)
    }

    // MARK: - Nickname
    func makeNicknameViewController() -> NicknameViewController {
        return NicknameViewController(viewModel: makeNicknameViewModel())
    }

    func makeNicknameViewModel() -> NicknameViewModel {
        return NicknameViewModel(viewType: .onboarding)
    }

    // MARK: - Location Permission
    func makeLocationPermissionViewController() {

    }
}
