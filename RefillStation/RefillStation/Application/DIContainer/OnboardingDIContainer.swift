//
//  OnboardingDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class OnboardingDIContainer: DIContainer {

    // MARK: - TabBarDIContainer
    func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer()
    }

    // MARK: - Coordinator
    func makeOnboardingCoordinator() -> OnboardingCoordinator {
        return OnboardingCoordinator(DIContainer: self)
    }

    // MARK: - Onboarding
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController(viewModel: makeOnboardingViewModel())
    }

    func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }

    // MARK: - Login
    func makeLoginViewController(viewType: LoginViewController.ViewType) -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel(), viewType: viewType)
    }

    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(OAuthLoginUseCase: makeLoginUseCase())
    }

    func makeLoginUseCase() -> OAuthLoginUseCase {
        return OAuthLoginUseCase(accountRepository: makeLoginRepository())
    }

    func makeLoginRepository() -> AsyncAccountRepositoryInterface {
        return AsyncAccountRepository()
    }

    // MARK: - Terms Permission
    func makeTermsPermissionViewController(requestValue: SignUpRequestValue) -> TermsPermissionViewController {
        let viewController = TermsPermissionViewController(
            viewModel: makeTermsPermissionViewModel(requestValue: requestValue)
        )
        return viewController
    }

    func makeTermsPermissionViewModel(requestValue: SignUpRequestValue) -> TermsPermissionViewModel {
        return TermsPermissionViewModel(requestValue: requestValue)
    }

    // MARK: - Terms Detail
    func makeTermsDetailViewController(termsType: TermsType) -> TermsDetailViewController {
        return TermsDetailViewController(termsType: termsType)
    }

    // MARK: - Location Permission
    func makeLocationPermissionViewController(requestValue: SignUpRequestValue) -> LocationPermissionViewController {
        return LocationPermissionViewController(viewModel: makeLocationPermissionViewModel(requestValue: requestValue))
    }

    func makeLocationPermissionViewModel(requestValue: SignUpRequestValue) -> LocationPermissionViewModel {
        return LocationPermissionViewModel(requestValue: requestValue)
    }
}
