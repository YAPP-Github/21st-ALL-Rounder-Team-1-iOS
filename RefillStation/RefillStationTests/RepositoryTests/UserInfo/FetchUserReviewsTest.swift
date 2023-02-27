//
//  FetchUserReviewsTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class FetchUserReviewsTest: XCTestCase {
    var sucessTestUnit: AsyncUserInfoRepository!
    var failureTestUnit: AsyncUserInfoRepository!
    let dataToReturn =
"""
{
    "message": "유저 리뷰 가져오기 성공",
    "status": 200,
    "data": [
        {
            "createdAt": "2023-01-29T18:29:31",
            "modifiedAt": "2023-01-29T18:29:31",
            "id": 1,
            "storeId": 1,
            "userId": 8,
            "reviewText": "리뷰테스트 찐막"
        },
        {
            "createdAt": "2023-01-29T18:56:24",
            "modifiedAt": "2023-01-29T18:56:24",
            "id": 3,
            "storeId": 1,
            "userId": 8,
            "reviewText": "리뷰테스트 찐찐막"
        },
        {
            "createdAt": "2023-01-29T18:56:43",
            "modifiedAt": "2023-01-29T18:56:43",
            "id": 4,
            "storeId": 1,
            "userId": 8,
            "reviewText": "리뷰테스트 찐찐막"
        },
        {
            "createdAt": "2023-01-30T02:34:14",
            "modifiedAt": "2023-01-30T02:34:14",
            "id": 5,
            "storeId": 103,
            "userId": 8,
            "reviewText": "리뷰테스트 찐찐막"
        },
        {
            "createdAt": "2023-01-30T02:34:15",
            "modifiedAt": "2023-01-30T02:34:15",
            "id": 6,
            "storeId": 103,
            "userId": 8,
            "reviewText": "리뷰테스트 찐찐막"
        }
    ]
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_fetchUserReviews_호출시_Review_배열을_반환하는지() async throws {
        // given
        do {
            // when
            let fetchUserReviewsResponse = try await sucessTestUnit.fetchUserReviews()
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<[ReviewDTO]>.self, from: dataToReturn)
            let fetchUserReviewsResult = networkResult.data.map { $0.toDomain() }
            XCTAssertEqual(fetchUserReviewsResponse, fetchUserReviewsResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_fetchUserReviews_호출시_urlParseFailed를_throw_하는지() async throws {
        // given
        do {
            // when
            _ = try await failureTestUnit.fetchUserReviews()
            // Then
            XCTFail()
        } catch {
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }

}
