//
//  FetchStoreListUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol FetchStoreListUseCaseInterface {
    func execute(requestValue: FetchStoreListUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
}

final class FetchStoreListUseCase: FetchStoreListUseCaseInterface {
    private let repository: HomeRepositoryInterface

    init(repository: HomeRepositoryInterface = MockHomeRepository()) {
        self.repository = repository
    }

    func execute(requestValue: FetchStoreListUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return repository.fetchStoreList(query: requestValue,
                                         completion: completion)
    }
}

struct FetchStoreListUseCaseRequestValue {
    let latitude: Double
    let longitude: Double
}
