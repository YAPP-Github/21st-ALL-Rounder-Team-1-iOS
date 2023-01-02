//
//  SearchStoreListUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol SearchStoreListUseCaseInterface {
    func execute(requestValue: SearchStoreListUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
}

final class SearchStoreListUseCase: SearchStoreListUseCaseInterface {
    private let repository: HomeRepositoryInterface

    init(repository: HomeRepositoryInterface = MockHomeRepository()) {
        self.repository = repository
    }

    func execute(requestValue: SearchStoreListUseCaseRequestValue,
                 completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return repository.searchStoreList(query: requestValue,
                                          completion: completion)
    }
}

struct SearchStoreListUseCaseRequestValue {
    let query: String
}
