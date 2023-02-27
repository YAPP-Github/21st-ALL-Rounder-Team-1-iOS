//
//  MockFetchStoreReviewsUseCase.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class MockFetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface {
    private let reviews: [Review]
    private let error: Error?

    init(reviews: [Review], error: Error? = nil) {
        self.reviews = reviews
        self.error = error
    }

    func execute(requestValue: FetchStoreReviewsRequestValue) async throws -> [Review] {
        if let error = error {
            throw error
        }
        return reviews
    }
}
