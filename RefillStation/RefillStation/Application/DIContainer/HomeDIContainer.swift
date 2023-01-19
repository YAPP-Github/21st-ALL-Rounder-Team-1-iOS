//
//  HomeDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class HomeDIContainer: DIContainer {
    private let navigationController = UINavigationController()
    private let networkService = NetworkService()

    // MARK: - Store Detail
    func makeStoreDetailDIContainer() -> StoreDetailDIContainer {
        return StoreDetailDIContainer(navigationController: navigationController)
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

    func makeFetchStoreListUseCase() {

    }

    func makeHomeRepository() -> HomeRepository {
        return HomeRepository(networkService: networkService)
    }
}
