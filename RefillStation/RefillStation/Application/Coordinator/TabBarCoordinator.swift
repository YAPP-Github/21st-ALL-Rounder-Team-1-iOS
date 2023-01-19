//
//  TabBarCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    let DIContainer: TabBarDIContainer
    private let rootViewController: UIViewController
    private let tabBarController: UITabBarController
    private let homeNavigationController: UINavigationController
    private let myPageNavigationController: UINavigationController

    init(
        DIContainer: TabBarDIContainer,
        viewController: UIViewController,
        tabBarController: UITabBarController,
        homeNavigationController: UINavigationController,
        myPageNavigationController: UINavigationController
    ) {
        self.DIContainer = DIContainer
        self.rootViewController = viewController
        self.tabBarController = tabBarController
        self.homeNavigationController = homeNavigationController
        self.myPageNavigationController = myPageNavigationController
    }

    func start() {
        tabBarController.addChild(homeNavigationController)
        tabBarController.addChild(myPageNavigationController)
    }
}
