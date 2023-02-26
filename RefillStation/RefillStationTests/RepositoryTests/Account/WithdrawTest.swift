//
//  WithdrawTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/25.
//

import XCTest
@testable import RefillStation

final class WithdrawTest: XCTestCase {
    var sucessTestUnit: AsyncAccountRepository!
    var failureTestUnit: AsyncAccountRepository!
    let dataToReturn =
"""
{
    "message": "유저 탈퇴 성공",
    "status": 200,
        "data":{
            "userId":Int
        }
}
"""
        .data(using: .utf8)!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"
        sucessTestUnit = AsyncAccountRepository(networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn),
                                                keychainManager: MockKeychainManager())
        failureTestUnit = AsyncAccountRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_withdraw_호출시_에러가_발생하지_않는지() async throws {
        // given
        do {
            // when
            _ = try await sucessTestUnit.withdraw()
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_withdraw_호출시_urlParseFailed를_throw_하는지() async throws {
        // given
        do {
            // when
            _ = try await failureTestUnit.withdraw()
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
