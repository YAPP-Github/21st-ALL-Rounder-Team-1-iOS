//
//  HomeSceneCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

final class HomeSceneCoordinator: Coordinator {
    var DIContainer: HomeSceneDIContainer
    let homeViewController = HomeViewController()

    init(DIContainer: HomeSceneDIContainer) {
        self.DIContainer = DIContainer
    }

    func start() {

    }

    func startHome() {

    }

    func startStoreDetailCoordinator(DIContainer: StoreDetailDIContainer) {

    }
}

extension HomeSceneCoordinator: HomeViewModelCoordinatorDelegate {
    func requestRegionButtonTapped() {

    }
}

extension HomeSceneCoordinator: RequestRegionViewModelCoordinatorDelegate {
    func requestButtonTapped() {

    }
}
