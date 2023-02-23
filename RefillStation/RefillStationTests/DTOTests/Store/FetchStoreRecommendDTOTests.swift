//
//  FetchStoreRecommendTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class FetchStoreRecommendDTOTests: XCTestCase {
    var fullContentUnit: FetchStoreRecommendDTO!
    var minimumContentUnit: FetchStoreRecommendDTO!

    override func setUpWithError() throws {
        fullContentUnit = FetchStoreRecommendDTO(recommendation: true, count: 10)

        minimumContentUnit = FetchStoreRecommendDTO(recommendation: nil, count: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_FetchStoreRecommendDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_FetchStoreRecommendResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toResponseValue()
        // then
        let expectationResult = FetchStoreRecommendResponseValue(recommendCount: 10, didRecommended: true)
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_FetchStoreRecommendDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_FetchStoreRecommendResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toResponseValue()
        // then
        let expectationResult = FetchStoreRecommendResponseValue(recommendCount: 0, didRecommended: false)
        XCTAssertEqual(domainResult, expectationResult)
    }
}

