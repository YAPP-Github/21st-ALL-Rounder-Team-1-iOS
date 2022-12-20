//
//  HomeSceneDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

final class HomeSceneDIContainer: DIContainer {
    // let baseNetworkService
    let homeSceneCoordinator: HomeSceneCoordinator

    init(coordinator: HomeSceneCoordinator) {
        self.homeSceneCoordinator = coordinator
    }
}
