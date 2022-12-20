//
//  HomeRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

final class HomeRepository: HomeRepositoryInterface {
    private var networkService: NetworkService

    init(service: NetworkService) {
        self.networkService = service
    }

    func fetchStoreList(query: FetchStoreListUseCaseRequestValue,
                        completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return RepositoryTask()
    }
    func searchStoreList(query: SearchStoreListUseCaseRequestValue,
                         completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return RepositoryTask()
    }
}
