//
//  SignOutTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/25.
//

import XCTest
@testable import RefillStation

final class SignOutTest: XCTestCase {
    var testUnit: AsyncAccountRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"
        testUnit = AsyncAccountRepository(networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: nil), keychainManager: MockKeychainManager())
    }
    override func tearDownWithError() throws {
        testUnit = nil
    }

    func test_signOut_호출시_에러가_발생하지_않는지() async throws {
        // given
        do {
            // when
            _ = try await testUnit.signOut()
            // then
        } catch {
            XCTFail("failed: \(error)")
        }
    }
}
