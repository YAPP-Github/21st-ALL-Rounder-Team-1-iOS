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
    private let repository: HomeRepositoryInterface

    init(repository: HomeRepositoryInterface = MockHomeRepository()) {
        self.repository = repository
    }

    func execute(requestValue: FetchStoresUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return repository.fetchStoreList(query: requestValue,
                                         completion: completion)
    }
}
