//
//  HomeRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

final class HomeRepository: HomeRepositoryInterface {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchStoreList(query: FetchStoreListUseCaseRequestValue,
                        completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return nil
    }
    func searchStoreList(query: SearchStoreListUseCaseRequestValue,
                         completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
