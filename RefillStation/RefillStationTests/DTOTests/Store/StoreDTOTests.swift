//
//  StoreDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class StoreDTOTests: XCTestCase {
    var fullContentUnit: StoreDTO!
    var minimumContentUnit: StoreDTO!

    override func setUpWithError() throws {
        fullContentUnit = StoreDTO(id: 0, userId: 0, name: "name", status: "", longitude: "", latitude: "", businessHour: [.init(day: "월월", time: "test time")], notice: "", address: "address", instaAccount: "instaAccount", callNumber: "", registrationNumber: "", isReady: true, distance: "10", imgStores: [.init(id: 0, storeId: 0, path: "")], storeRefillGuides: [.init(createdAt: "", modifiedAt: "", id: 0, storeId: 0, imgPath: "", removedAt: "")])

        minimumContentUnit = StoreDTO(id: nil, userId: nil, name: nil, status: nil, longitude: nil, latitude: nil, businessHour: nil, notice: nil, address: nil, instaAccount: nil, callNumber: nil, registrationNumber: nil, isReady: nil, distance: nil, imgStores: [], storeRefillGuides: [])
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_StoreDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_Store를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toDomain()
        // then
        let expectationResult = Store(storeId: 0, name: "name", address: "address", distance: 10, phoneNumber: "", snsAddress: "instaAccount", didUserRecommended: false, recommendedCount: 0, imageURL: [""], businessHour: [.init(day: .mon, time: "test time")], notice: "", storeRefillGuideImagePaths: [""])
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_StoreDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_Store를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toDomain()
        // then
        let expectationResult = Store(storeId: 0, name: "", address: "", distance: 0, phoneNumber: "", snsAddress: "", didUserRecommended: false, recommendedCount: 0, imageURL: [], businessHour: [], notice: "", storeRefillGuideImagePaths: [])
        XCTAssertEqual(domainResult, expectationResult)
    }
}

