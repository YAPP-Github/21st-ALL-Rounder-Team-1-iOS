//
//  RecommendStoreTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest

import XCTest
@testable import RefillStation

extension RecommendStoreResponseValue: Equatable {
    public static func == (lhs: RecommendStoreResponseValue, rhs: RecommendStoreResponseValue) -> Bool {
        return lhs.didRecommended == rhs.didRecommended && lhs.recommendCount == rhs.recommendCount
    }
}

class RecommendStoreTest: XCTestCase {

    var sucessTestUnit: AsyncStoreRepository!
    var failureTestUnit: AsyncStoreRepository!
    let dataToReturn =
"""
{
    "message": "추천하기 성공",
    "status": 200,
    "data": {
        "recommendationId": 7,
        "isRecommendation": true,
        "count": 2
    }
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncStoreRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncStoreRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_recommendStore_호출시_storeRecommendResponse를_반환하는지() async throws {
        // given
        let requestValue = RecommendStoreRequestValue(storeId: 330, type: .recommend)

        do {
            // when
            let recommendResponse = try await sucessTestUnit.recommendStore(requestValue: requestValue)
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<StoreRecommendDTO>.self, from: dataToReturn)
            let storeRecommendResult = networkResult.data.toResponseValue()
            XCTAssertEqual(recommendResponse, storeRecommendResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_recommendStore_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = RecommendStoreRequestValue(storeId: 330, type: .recommend)

        do {
            // when
            _ = try await failureTestUnit.recommendStore(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
