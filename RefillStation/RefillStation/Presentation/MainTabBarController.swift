//
//  MainTabBarController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = Asset.Colors.gray4.color
    }
}
