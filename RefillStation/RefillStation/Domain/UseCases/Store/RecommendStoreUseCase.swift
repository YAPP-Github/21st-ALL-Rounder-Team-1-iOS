//
//  RecommendStoreUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct RecommendStoreRequestValue {
    enum `Type` {
        case recommend
        case cancel
    }
    let storeId: Int
    let type: `Type`
}

struct RecommendStoreResponseValue {
    let recommendCount: Int
    let didRecommended: Bool
}

protocol RecommendStoreUseCaseInterface {
    func execute(requestValue: RecommendStoreRequestValue) async throws -> RecommendStoreResponseValue
}

final class RecommendStoreUseCase: RecommendStoreUseCaseInterface {
    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: RecommendStoreRequestValue) async throws -> RecommendStoreResponseValue {
        return try await storeRepository.recommendStore(requestValue: requestValue)
    }
}
