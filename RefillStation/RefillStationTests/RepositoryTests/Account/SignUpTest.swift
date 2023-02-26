//
//  SignUpTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class SignUpTest: XCTestCase {
    var sucessTestUnit: AsyncAccountRepository!
    var failureTestUnit: AsyncAccountRepository!
    let dataToReturn =
"""
{
    "message": "회원가입 완료",
    "status": 200,
    "data": "jwtToken"
}
"""
        .data(using: .utf8)!


    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncAccountRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncAccountRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_signUp_호출시_jwtToken을_반환하는지() async throws {
        // given
        let requestValue = SignUpRequestValue(name: nil,
                                              email: nil,
                                              imagePath: nil,
                                              oauthType: "oauthType",
                                              oauthIdentity: "oauthIdentity")
        do {
            // when
            let jwtToken = try await sucessTestUnit.signUp(
                requestValue: requestValue
            )
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<String>.self, from: dataToReturn)
            let signUpResult = networkResult.data
            XCTAssertEqual(jwtToken, signUpResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_signUp_호출시_urlParseFailed를_throw_하는지() async throws {
        // given
        let requestValue = SignUpRequestValue(name: nil,
                                              email: nil,
                                              imagePath: nil,
                                              oauthType: "oauthType",
                                              oauthIdentity: "oauthIdentity")
        do {
            // when
            _ = try await failureTestUnit.signUp(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
