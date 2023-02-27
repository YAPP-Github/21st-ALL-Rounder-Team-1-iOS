//
//  MockFetchStoreRecommendUseCase.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class MockFetchStoreRecommendUseCase: FetchStoreRecommendUseCaseInterface {
    
    private let fetchStoreRecommendResponseValue: FetchStoreRecommendResponseValue
    private let error: Error?

    init(fetchStoreRecommendResponseValue: FetchStoreRecommendResponseValue, error: Error? = nil) {
        self.fetchStoreRecommendResponseValue = fetchStoreRecommendResponseValue
        self.error = error
    }

    func execute(requestValue: RefillStation.FetchStoreRecommendRequestValue) async throws -> RefillStation.FetchStoreRecommendResponseValue {
        if let error = error {
            throw error
        }
        return fetchStoreRecommendResponseValue
    }
}
