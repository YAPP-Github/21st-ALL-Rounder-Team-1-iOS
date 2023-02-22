//
//  RegisterReviewTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

class RegisterReviewTest: XCTestCase {

    var sucessTestUnit: AsyncRegisterReviewRepository!
    var failureTestUnit: AsyncRegisterReviewRepository!
    let dataToReturn =
"""
{
    "message": "리뷰 저장에 성공했습니다.",
    "status": 200,
    "data": {
        "reviewId": 4,
        "imgReviewIds": [
            7,
            8,
            9
        ],
        "reviewTagLogIds": [
            4,
            5,
            6
        ]
    }
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncRegisterReviewRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn),
            awsService: MockAWSS3Service()
        )
        failureTestUnit = AsyncRegisterReviewRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn),
            awsService: MockAWSS3Service()
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_registerReview_호출시_에러가_발생하지_않는지() async throws {
        // given
        let requestValue = RegisterReviewRequestValue(storeId: 0, tagIds: [],
                                                      images: [UIImage(), UIImage()],
                                                      description: "")

        do {
            // when
            _ = try await sucessTestUnit.registerReview(query: requestValue)
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_registerReview_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = RegisterReviewRequestValue(storeId: 0, tagIds: [], images: [], description: "")

        do {
            // when
            _ = try await failureTestUnit.registerReview(query: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
