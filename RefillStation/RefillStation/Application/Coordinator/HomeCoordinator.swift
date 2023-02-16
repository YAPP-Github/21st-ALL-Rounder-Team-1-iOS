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
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func showStoreDetail(store: Store) {
        let storeDetailDIContainer = DIContainer.makeStoreDetailDIContainer(store: store)
        let storeDetailCoordinator = storeDetailDIContainer.makeStoreDetailCoordinator()
        storeDetailCoordinator.start()
    }

    func showRequestRegion() {
        let requestRegionViewController = DIContainer.makeRequestRegionViewController()
        requestRegionViewController.coordinator = self
        navigationController.pushViewController(requestRegionViewController, animated: true)
    }

    func popRequestRegion() {
        navigationController.popViewController(animated: true)
    }
}
