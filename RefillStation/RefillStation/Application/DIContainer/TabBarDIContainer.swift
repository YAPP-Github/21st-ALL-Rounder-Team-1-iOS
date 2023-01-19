//
//  TabBarDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarDIContainer: DIContainer {
    private let rootViewController: UIViewController
    private let tabBarController = MainTabBarController()
    private let homeNavigationController = UINavigationController()
    private let myPageNaviagtionConroller = UINavigationController()

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func makeTabBarCoordinator() -> TabBarCoordinator {
        return TabBarCoordinator(
            DIContainer: self,
            viewController: rootViewController,
            tabBarController: tabBarController,
            homeNavigationController: homeNavigationController,
            myPageNavigationController: myPageNaviagtionConroller
        )
    }

    func makeHomeDIContainer() -> HomeDIContainer {
        return HomeDIContainer(navigationController: homeNavigationController)
    }

    func makeMyPageDIContainer() {

    }
}
