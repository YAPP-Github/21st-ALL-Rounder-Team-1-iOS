//
//  StoreDetailDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

final class StoreDetailDIContainer: DIContainer {

    private let networkService = NetworkService()

    func makeFetchProductListUseCase() -> FetchProductListUseCaseInterface {
        return FetchProductListUseCase(productListRepository: makeProductListRepository())
    }

    func makeProductListRepository() -> ProductListRepositoryInterface {
        return ProductListRepository(networkService: networkService)
    }

    func makeStoreDetailViewController() -> StoreDetailViewController {
        return StoreDetailViewController(viewModel: makeStoreDetailViewModel())
    }

    func makeStoreDetailViewModel() -> StoreDetailViewModel {
        return StoreDetailViewModel(
            fetchProductListUseCase: makeFetchProductListUseCase()
        )
    }
}
