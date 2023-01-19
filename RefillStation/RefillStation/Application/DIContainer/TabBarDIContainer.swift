//
//  TabBarDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class TabBarDIContainer: DIContainer {
    private let tabBarController = UITabBarController()

    func makeTabBarCoordinator() -> TabBarCoordinator {
        return TabBarCoordinator(DIContainer: self,
                                 tabBarController: tabBarController)
    }
}
