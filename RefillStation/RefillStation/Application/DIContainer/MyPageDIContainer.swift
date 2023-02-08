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
        return MyPageViewModel()
    }

    func makeMyPageUseCase() -> FetchUserInfoUseCase {
        return FetchUserInfoUseCase()
    }

    func makeMyPageRepository() {

    }

    func makeUserLevelViewController() {

    }

    func makeTermsDetailViewController(termsType: TermsType) -> TermsDetailViewController {
        return TermsDetailViewController(termsType: termsType)
    }

    func makeEditProfileViewController() -> NicknameViewController {
        return NicknameViewController(viewModel: makeEditProfileViewModel())
    // MARK: - Account Management

    func makeAccountManagementViewController() -> AccountManagementViewController {
        return AccountManagementViewController(viewModel: makeAccountManagementViewModel())
    }

    func makeAccountManagementViewModel() -> AccountManagementViewModel {
        return AccountManagementViewModel(signOutUseCase: makeSignOutUseCase(),
                                          withdrawUseCase: makeWithdrawUseCase())
    }

    func makeSignOutUseCase() -> SignOutUseCase {
        return SignOutUseCase()
    }

    func makeWithdrawUseCase() -> WithdrawUseCase {
        return WithdrawUseCase(accountRepository: makeAccountRepository())
    }

    func makeAccountRepository() -> AccountRepository {
        return AccountRepository()
    }
}
