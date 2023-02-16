//
//  MyPageCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var DIContainer: MyPageDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: MyPageDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        startMyPage()
    }

    func startMyPage() {
        let myPageViewController = DIContainer.makeMyPageViewController()
        myPageViewController.coordinator = self
        navigationController.pushViewController(myPageViewController, animated: true)
    }

    func showLevelInfo() {
        let levelInfoViewController = DIContainer.makeUserLevelViewController()
        navigationController.pushViewController(levelInfoViewController, animated: true)
    }

    func showEditProfile(user: User) {
        let editViewContoller = DIContainer.makeEditProfileViewController(user: user)
        editViewContoller.coordinator = self
        navigationController.pushViewController(editViewContoller, animated: true)
    }

    func showManagementAccount() {
        let accountManagementViewController = DIContainer.makeAccountManagementViewController()
        accountManagementViewController.coordinator = self
        navigationController.pushViewController(accountManagementViewController, animated: true)
    }

    func showTermsDetails(termsType: TermsType) {
        let termsDetailViewController = DIContainer.makeTermsDetailViewController(termsType: termsType)
        navigationController.pushViewController(termsDetailViewController, animated: true)
    }

    func showLogin() {
        let onboardingDIContainer = DIContainer.makeOnboardingDIContainer()
        let onboardingCoordinator = onboardingDIContainer.makeOnboardingCoordinator()
        onboardingCoordinator.showLogin(viewType: .lookAround)
    }

    func popEditProfile() {
        navigationController.popViewController(animated: true)
    }
}
