//
//  FetchProductsTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2022/11/23.
//

import XCTest
@testable import RefillStation

class FetchProductsTest: XCTestCase {

    var sucessTestUnit: AsyncStoreRepository!
    var failureTestUnit: AsyncStoreRepository!
    let dataToReturn =
"""
{
    "message": "상품 정보 가져오기 성공",
    "status": 200,
    "data": [
        {
            "createdAt": "2023-02-18T16:54:11",
            "modifiedAt": "2023-02-18T07:55:06",
            "id": 91,
            "storeId": 340,
            "title": "시리얼 그래놀라",
            "price": null,
            "unit": "G",
            "brand": "켈로그(Kellogg)",
            "category": "식재료",
            "imgPath": null,
            "isHided": null,
            "isReady": true
        }
    ]
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

    func test_올바른_baseURL로_fetchProducts_호출시_Products_배열을_반환하는지() async throws {
        // given
        let requestValue = FetchProductsRequestValue(storeId: 330)
        // when
        let products = try await sucessTestUnit.fetchProducts(requestValue: requestValue)
        // then
        do {
            let networkResult = try JSONDecoder().decode(NetworkResult<[ProductDTO]>.self, from: dataToReturn)
            let productsResult = networkResult.data.map { $0.toDomain() }
            XCTAssertEqual(products, productsResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_fetchProducts_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = FetchProductsRequestValue(storeId: 330)

        do {
            // when
            _ = try await failureTestUnit.fetchProducts(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
