//
//  TabBarDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarDIContainer: DIContainer {
    private let window: UIWindow?
    private let tabBarController = MainTabBarController()
    private let homeNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: "탐색",
                                                image: UIImage(systemName: "magnifyingglass"),
                                                selectedImage: UIImage(systemName: "magnifyingglass"))
        return navigationController
    }()
    private let myPageNaviagtionConroller: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: "마이",
                                                image: UIImage(systemName: "person"),
                                                selectedImage: UIImage(systemName: "person"))
        return navigationController
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    func makeTabBarCoordinator() -> TabBarCoordinator {
        return TabBarCoordinator(
            DIContainer: self,
            window: window,
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
