//
//  HomeDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class HomeDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService.shared

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Store Detail
    func makeStoreDetailDIContainer(store: Store) -> StoreDetailDIContainer {
        return StoreDetailDIContainer(navigationController: navigationController, store: store)
    }

    // MARK: - Coordinator
    func makeHomeCoordinator() -> HomeCoordinator {
        return HomeCoordinator(DIContainer: self,
                               navigationController: navigationController)
    }

    // MARK: - Home
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(viewModel: makeHomeViewModel())
    }

    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }

    func makeFetchStoresUseCase() {

    }

    // MARK: - Request Region
    func makeRequestRegionViewController() -> RequestRegionViewController {
        return RequestRegionViewController(viewModel: makeRequestRegionViewModel())
    }

    func makeRequestRegionViewModel() -> RequestRegionViewModel {
        return RequestRegionViewModel()
    }
}
