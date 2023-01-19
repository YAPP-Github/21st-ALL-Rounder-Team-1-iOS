//
//  HomeSceneCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var DIContainer: HomeDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: HomeDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        startHome()
    }

    func startHome() {
        let homeViewController = DIContainer.makeHomeViewController()
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func showStoreDetail() {
        let storeDetailDIContainer = DIContainer.makeStoreDetailDIContainer()
        let storeDetailCoordinator = storeDetailDIContainer.makeStoreDetailCoordinator()
        storeDetailCoordinator.start()
    }
}
