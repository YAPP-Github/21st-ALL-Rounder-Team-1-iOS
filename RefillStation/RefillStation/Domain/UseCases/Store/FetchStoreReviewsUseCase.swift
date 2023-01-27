//
//  FetchStoreReviewsUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct FetchStoreReviewsRequestValue {
    let storeId: Int
}

protocol FetchStoreReviewsUseCaseInterface {
    func execute(requestValue: FetchStoreReviewsRequestValue, completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable?
}

final class FetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = MockStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoreReviewsRequestValue, completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
