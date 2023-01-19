//
//  StoreDetailCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class StoreDetailCoordinator: Coordinator {
    let DIContainer: StoreDetailDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: StoreDetailDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        let storeDetailViewController = DIContainer.makeStoreDetailViewController()
        navigationController.pushViewController(storeDetailViewController, animated: true)
    }
}
