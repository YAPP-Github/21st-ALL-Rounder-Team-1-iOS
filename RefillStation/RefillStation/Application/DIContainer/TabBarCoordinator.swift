//
//  TabBarCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    let DIContainer: TabBarDIContainer
    private let tabBarController: UITabBarController

    init(DIContainer: TabBarDIContainer, tabBarController: UITabBarController) {
        self.DIContainer = DIContainer
        self.tabBarController = tabBarController
    }

    func start() {

    }
}
