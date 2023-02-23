//
//  ProductDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class ProductDTOTests: XCTestCase {
    var fullContentUnit: ProductDTO!
    var minimumContentUnit: ProductDTO!

    override func setUpWithError() throws {
        fullContentUnit = ProductDTO(createdAt: "", modifiedAt: "", id: 0, storeId: 0, title: "title", price: 10, unit: "mg", brand: "brand", category: "샴푸", imgPath: "imgPath", isHided: true, isReady: true)

        minimumContentUnit = ProductDTO(createdAt: nil, modifiedAt: nil, id: nil, storeId: nil, title: nil, price: nil, unit: nil, brand: nil, category: nil, imgPath: nil, isHided: nil, isReady: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_ProductDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_Product를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toDomain()
        // then
        let expectationResult = Product(name: "title", brand: "brand", measurement: "mg", price: 10, imageURL: "imgPath", category: .init(title: "샴푸"))
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_ProductDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_Product를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toDomain()
        // then
        let expectationResult = Product(name: "", brand: "", measurement: "", price: 0, imageURL: "", category: .init(title: ""))
        XCTAssertEqual(domainResult, expectationResult)
    }
}
