//
//  FetchProductListUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct FetchProductsRequestValue {
    let storeId: Int
}

protocol FetchProductsUseCaseInterface {
    func execute(requestValue: FetchProductsRequestValue) async throws -> [Product]
}

final class FetchProductsUseCase: FetchProductsUseCaseInterface {
    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchProductsRequestValue) async throws -> [Product] {
        return try await storeRepository.fetchProducts(requestValue: requestValue)
    }
}
