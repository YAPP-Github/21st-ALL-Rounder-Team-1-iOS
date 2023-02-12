//
//  FetchStoresUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct FetchStoresUseCaseRequestValue {
    let latitude: Double
    let longitude: Double
}

protocol FetchStoresUseCaseInterface {
    func execute(requestValue: FetchStoresUseCaseRequestValue) async throws -> [Store]
}

final class FetchStoresUseCase: FetchStoresUseCaseInterface {
    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoresUseCaseRequestValue) async throws -> [Store] {
        return try await storeRepository.fetchStores(requestValue: requestValue)
    }
}
