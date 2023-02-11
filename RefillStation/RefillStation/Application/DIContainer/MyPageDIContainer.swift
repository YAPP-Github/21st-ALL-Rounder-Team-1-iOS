//
//  MyPageDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class MyPageDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService.shared

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func makeMyPageCoordinator() -> MyPageCoordinator {
        return MyPageCoordinator(DIContainer: self,
                                 navigationController: navigationController)
    }

    // MARK: - My Page
    func makeMyPageViewController() -> MyPageViewController {
        return MyPageViewController(viewModel: makeMyPageViewModel())
    }

    func makeMyPageViewModel() -> MyPageViewModel {
        return MyPageViewModel(fetchUserInfoUseCase: makeMyPageUseCase())
    }

    func makeMyPageUseCase() -> FetchUserInfoUseCaseInterface {
        return FetchUserInfoUseCase(userInfoRepository: makeMyPageRepository())
    }

    func makeMyPageRepository() -> UserInfoRepositoryInterface {
        return UserInfoRepository()
    }

    // MARK: - Login
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }

    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(OAuthLoginUseCase: makeLoginUseCase())
    }

    func makeLoginUseCase() -> OAuthLoginUseCase {
        return OAuthLoginUseCase(accountRepository: makeLoginRepository())
    }

    func makeLoginRepository() -> AccountRepositoryInterface {
        return AccountRepository()
    }

    // MARK: - Level
    func makeUserLevelViewController() -> UserLevelViewController {
        return UserLevelViewController(viewModel: makeUserLevelViewModel())
    }

    func makeUserLevelViewModel() -> UserLevelViewModel {
        return UserLevelViewModel(fetchUserReviewsUseCase: makeFetchUserReviewUseCase())
    }

    func makeFetchUserReviewUseCase() -> FetchUserReviewsUseCaseInterface {
        return FetchUserReviewsUseCase(userInfoRepository: makeUserInfoRepository())
    }

    func makeUserInfoRepository() -> UserInfoRepositoryInterface {
        return UserInfoRepository()
    }

    // MARK: - Terms Detail
    func makeTermsDetailViewController(termsType: TermsType) -> TermsDetailViewController {
        return TermsDetailViewController(termsType: termsType)
    }

    // MARK: - Edit Profile
    func makeEditProfileViewController(user: User) -> NicknameViewController {
        return NicknameViewController(viewModel: makeEditProfileViewModel(user: user))
    }

    func makeEditProfileViewModel(user: User) -> NicknameViewModel {
        return NicknameViewModel(viewType: .myPage,
                                 user: user,
                                 editProfileUseCase: makeEditProfileUseCase(),
                                 validNicknameUseCase: makeValidNicknameUseCase())
    }

    func makeEditProfileUseCase() -> EditProfileUseCaseInterface {
        return EditProfileUseCase(userInfoRepository: makeUserInfoRepository())
    }

    func makeValidNicknameUseCase() -> ValidNicknameUseCaseInterface {
        return ValidNicknameUseCase(userInfoRepository: makeUserInfoRepository())
    }

    // MARK: - Account Management

    func makeAccountManagementViewController() -> AccountManagementViewController {
        return AccountManagementViewController(viewModel: makeAccountManagementViewModel())
    }

    func makeAccountManagementViewModel() -> AccountManagementViewModel {
        return AccountManagementViewModel(signOutUseCase: makeSignOutUseCase(),
                                          withdrawUseCase: makeWithdrawUseCase())
    }

    func makeSignOutUseCase() -> SignOutUseCase {
        return SignOutUseCase(accountRepository: makeAccountRepository())
    }

    func makeWithdrawUseCase() -> WithdrawUseCase {
        return WithdrawUseCase(accountRepository: makeAccountRepository())
    }

    func makeAccountRepository() -> AccountRepository {
        return AccountRepository()
    }
}
