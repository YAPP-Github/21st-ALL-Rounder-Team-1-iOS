//
//  FetchStoreRecommendUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

struct FetchStoreRecommendRequestValue {
    let storeId: Int
}

struct FetchStoreRecommendResponseValue {
    let recommendCount: Int
    let didRecommended: Bool
}

protocol FetchStoreRecommendUseCaseInterface {
    func execute(requestValue: FetchStoreRecommendRequestValue, completion: @escaping (Result<FetchStoreRecommendResponseValue, Error>) -> Void) -> Cancellable?
}

final class FetchStoreRecommendUseCaseRequestValue: FetchStoreRecommendUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = StoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoreRecommendRequestValue, completion: @escaping (Result<FetchStoreRecommendResponseValue, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
