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
        let myPageViewController = DIContainer.makeMyPageViewController()
        navigationController.pushViewController(myPageViewController, animated: true)
    }
}
