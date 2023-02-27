//
//  MockRegisterReviewUseCase.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class MockRegisterReviewUseCase: RegisterReviewUseCaseInterface {

    private let error: Error?

    init(error: Error? = nil) {
        self.error = error
    }

    func execute(requestValue: RegisterReviewRequestValue) async throws {
        if let error = error {
            throw error
        }
    }
}
