//
//  MockRecommendStoreUseCase.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class MockRecommendStoreUseCase: RecommendStoreUseCaseInterface {
    
    private let recommendStoreResponseValue: RecommendStoreResponseValue
    private let error: Error?

    init(recommendStoreResponseValue: RecommendStoreResponseValue, error: Error? = nil) {
        self.recommendStoreResponseValue = recommendStoreResponseValue
        self.error = error
    }

    func execute(requestValue: RefillStation.RecommendStoreRequestValue) async throws -> RefillStation.RecommendStoreResponseValue {
        if let error = error {
            throw error
        }
        return recommendStoreResponseValue
    }
}
