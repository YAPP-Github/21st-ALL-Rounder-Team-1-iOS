//
//  StoreDetailSceneCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/24.
//

import UIKit

final class StoreDetailSceneCoordinator: Coordinator {
    var DIContainer: StoreDetailDIContainer
    private weak var navigationController: UINavigationController?

    init(
        navigationController: UINavigationController,
        storeDetailDIContainer: StoreDetailDIContainer
    ) {
        self.DIContainer = storeDetailDIContainer
    }

    func start() {
        let storeDetailVC = DIContainer.makeStoreDetailViewController()
        navigationController?.pushViewController(storeDetailVC, animated: true)
    }
}
