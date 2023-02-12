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
    func execute(requestValue: FetchStoreReviewsRequestValue) async throws -> [Review]
}

final class FetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface {
    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoreReviewsRequestValue) async throws -> [Review] {
        return try await storeRepository.fetchStoreReviews(requestValue: requestValue)
    }
}
