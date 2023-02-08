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

    func startLevelInfo() {

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
}
