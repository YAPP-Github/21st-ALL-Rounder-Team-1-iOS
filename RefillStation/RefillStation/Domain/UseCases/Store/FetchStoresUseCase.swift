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
    func execute(requestValue: FetchStoresUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
}

final class FetchStoresUseCase: FetchStoresUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = MockStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoresUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return storeRepository.fetchStores(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
