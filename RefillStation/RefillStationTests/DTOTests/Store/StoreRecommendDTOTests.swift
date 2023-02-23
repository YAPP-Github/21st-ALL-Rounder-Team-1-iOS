//
//  StoreRecommendDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class StoreRecommendDTOTests: XCTestCase {
    var fullContentUnit: StoreRecommendDTO!
    var minimumContentUnit: StoreRecommendDTO!

    override func setUpWithError() throws {
        fullContentUnit = StoreRecommendDTO(isRecommendation: true, count: 10)

        minimumContentUnit = StoreRecommendDTO(isRecommendation: nil, count: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_StoreRecommendDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_RecommendStoreResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toResponseValue()
        // then
        let expectationResult = RecommendStoreResponseValue(recommendCount: 10, didRecommended: true)
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_StoreRecommendDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_RecommendStoreResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toResponseValue()
        // then
        let expectationResult = RecommendStoreResponseValue(recommendCount: 0, didRecommended: false)
        XCTAssertEqual(domainResult, expectationResult)
    }
}
