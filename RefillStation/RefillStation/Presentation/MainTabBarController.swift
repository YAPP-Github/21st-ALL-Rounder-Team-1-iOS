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
        setTabBarItems()
        view.backgroundColor = .white
    }

    private func setTabBarItems() {
        guard let tabBarItems = tabBar.items else { return }
        tabBarItems[0].image = Asset.Images.iconBell.image
        tabBarItems[1].image = Asset.Images.iconAlbum.image
    }
}
