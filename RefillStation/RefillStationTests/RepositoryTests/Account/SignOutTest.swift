//
//  SingOutTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class SignOutTest: XCTestCase {
    var sucessTestUnit: AsyncAccountRepository!
    var failureTestUnit: AsyncAccountRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"
        
        sucessTestUnit = AsyncAccountRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: nil)
        )
        failureTestUnit = AsyncAccountRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: nil)
        )
    }

    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_KeyChain에_item이_있을_때_signOut_호출시_에러가_발생하지_않는지() async throws {
        // given
        _ = KeychainManager.shared.addItem(key: "lookAroundToken", value: "token")
        _ = KeychainManager.shared.addItem(key: "token", value: "token")
        do {
            // when
            _ = try await sucessTestUnit.signOut()
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_KeyChain에_item이_없을_때_signOut_호출시_noData를_throw_하는지() async throws {
        // given
        do {
            // when
            _ = try await failureTestUnit.signOut()
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? KeychainManager.KeychainError, .noData)
        }
    }

}
