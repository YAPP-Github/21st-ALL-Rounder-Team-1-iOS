//
//  FetchStoreRecommendTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

extension FetchStoreRecommendResponseValue: Equatable {
    public static func == (lhs: FetchStoreRecommendResponseValue, rhs: FetchStoreRecommendResponseValue) -> Bool {
        return lhs.didRecommended == rhs.didRecommended && lhs.recommendCount == rhs.recommendCount
    }
}

class FetchStoreRecommendTest: XCTestCase {
    
    var sucessTestUnit: AsyncStoreRepository!
    var failureTestUnit: AsyncStoreRepository!
    let dataToReturn =
"""
{
    "message": "추천 불러오기 성공",
    "status": 200,
    "data": {
        "recommendation": false,
        "count": 5
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
    
    func test_올바른_baseURL로_fetchStoreRecommend_호출시_storeRecommendResponse를_반환하는지() async throws {
        // given
        let requestValue = FetchStoreRecommendRequestValue(storeId: 330)
        
        do {
            // when
            let storeRecommendResponse = try await sucessTestUnit.fetchStoreRecommend(requestValue: requestValue)
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<FetchStoreRecommendDTO>.self, from: dataToReturn)
            let fetchStoreRecommendResult = networkResult.data.toResponseValue()
            XCTAssertEqual(storeRecommendResponse, fetchStoreRecommendResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }
    
    func test_잘못된_baseURL로_fetchStoreRecommend_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = FetchStoreRecommendRequestValue(storeId: 330)
        
        do {
            // when
            _ = try await failureTestUnit.fetchStoreRecommend(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
