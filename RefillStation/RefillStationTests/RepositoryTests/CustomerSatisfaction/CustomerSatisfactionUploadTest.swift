//
//  CustomerSatisfactionUploadTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest

import XCTest
@testable import RefillStation

class CustomerSatisfactionUploadTest: XCTestCase {

    var sucessTestUnit: AsyncCustomerSatisfactionRepository!
    var failureTestUnit: AsyncCustomerSatisfactionRepository!
    let dataToReturn =
"""
{
    "message": "CS 접수 성공",
    "status": 200,
    "data": {
        "customerSatisfactionId": 2
    }
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncCustomerSatisfactionRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn),
            userInfoRepository: MockUserInfoRepository()
        )
        failureTestUnit = AsyncCustomerSatisfactionRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn),
            userInfoRepository: MockUserInfoRepository()
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL과_reportUser_type으로_upload_호출시_에러가_발생하지_않는지() async throws {
        // given
        let requestValue = CustomerSatisfactionRequestValue(userId: 0, content: "", type: .reportUser)

        do {
            // when
            _ = try await sucessTestUnit.upload(requestValue: requestValue)
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_올바른_baseURL과_requestRegion_type으로_upload_호출시_에러가_발생하지_않는지() async throws {
        // given
        let requestValue = CustomerSatisfactionRequestValue(userId: 0, content: "", type: .requestRegion)

        do {
            // when
            _ = try await sucessTestUnit.upload(requestValue: requestValue)
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_upload_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = CustomerSatisfactionRequestValue(userId: 0, content: "", type: .reportUser)

        do {
            // when
            _ = try await failureTestUnit.upload(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
