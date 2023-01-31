//
//  TabBarCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    let DIContainer: TabBarDIContainer
    private var window: UIWindow?
    private let tabBarController: UITabBarController
    private let homeNavigationController: UINavigationController
    private let myPageNavigationController: UINavigationController

    init(
        DIContainer: TabBarDIContainer,
        window: UIWindow?,
        tabBarController: UITabBarController,
        homeNavigationController: UINavigationController,
        myPageNavigationController: UINavigationController
    ) {
        self.DIContainer = DIContainer
        self.window = window
        self.tabBarController = tabBarController
        self.homeNavigationController = homeNavigationController
        self.myPageNavigationController = myPageNavigationController
    }

    func start() {
        window?.rootViewController = tabBarController
        tabBarController.addChild(homeNavigationController)
        tabBarController.addChild(myPageNavigationController)
        startHome()
    }

    private func startHome() {
        let homeDIContainer = DIContainer.makeHomeDIContainer()
        let homeCoordinator = homeDIContainer.makeHomeCoordinator()
        homeCoordinator.start()

        let myPageDIContainer = DIContainer.makeMyPageDIContainer()
        let myPageCoordinator = myPageDIContainer.makeMyPageCoordinator()
        myPageCoordinator.start()
    }
}
