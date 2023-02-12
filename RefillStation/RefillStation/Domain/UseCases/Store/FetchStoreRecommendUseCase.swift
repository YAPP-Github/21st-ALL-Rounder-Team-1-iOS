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
    func execute(requestValue: FetchStoreRecommendRequestValue) async throws -> FetchStoreRecommendResponseValue
}

final class FetchStoreRecommendUseCase: FetchStoreRecommendUseCaseInterface {
    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchStoreRecommendRequestValue) async throws -> FetchStoreRecommendResponseValue {
        return try await storeRepository.fetchStoreRecommend(requestValue: requestValue)
    }
}
