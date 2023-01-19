//
//  TabBarCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    let DIContainer: TabBarDIContainer
    private var rootViewController: UIViewController
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
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = tabBarController
        tabBarController.addChild(homeNavigationController)
        let homeDIContainer = DIContainer.makeHomeDIContainer()
        let homeCoordinator = homeDIContainer.makeHomeCoordinator()
        homeCoordinator.start()
        tabBarController.addChild(myPageNavigationController)
    }
}
