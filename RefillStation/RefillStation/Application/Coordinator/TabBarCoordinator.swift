//
//  TabBarCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    let DIContainer: TabBarDIContainer
    private var window: UIWindow? = (UIApplication.shared.delegate as? AppDelegate)?.window
    private let tabBarController: UITabBarController
    private let homeNavigationController: UINavigationController
    private let myPageNavigationController: UINavigationController

    init(
        DIContainer: TabBarDIContainer,
        tabBarController: UITabBarController,
        homeNavigationController: UINavigationController,
        myPageNavigationController: UINavigationController
    ) {
        self.DIContainer = DIContainer
        self.tabBarController = tabBarController
        self.homeNavigationController = homeNavigationController
        self.myPageNavigationController = myPageNavigationController
    }

    func start() {
        window?.rootViewController = tabBarController
        tabBarController.addChild(homeNavigationController)
        tabBarController.addChild(myPageNavigationController)
        startHome()
        startMyPage()
    }

    private func startHome() {
        let homeDIContainer = DIContainer.makeHomeDIContainer()
        let homeCoordinator = homeDIContainer.makeHomeCoordinator()
        homeCoordinator.start()
    }

    private func startMyPage() {
        let myPageDIContainer = DIContainer.makeMyPageDIContainer()
        let homeCoordinator = myPageDIContainer.makeMyPageCoordinator()
        homeCoordinator.start()
    }
}
