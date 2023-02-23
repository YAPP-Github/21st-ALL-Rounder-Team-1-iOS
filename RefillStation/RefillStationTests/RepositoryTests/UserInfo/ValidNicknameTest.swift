//
//  ValidNicknameTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class ValidNicknameTest: XCTestCase {
    var sucessTestUnit: AsyncUserInfoRepository!
    var failureTestUnit: AsyncUserInfoRepository!
    let dataToReturn =
"""
{
    "message": "닉네임 중복 확인 완료",
    "status": 200,
    "data": true
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }
    
    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_validNickname_호출시_닉네임_중복여부를_반환하는지() async throws {
        // given
        let requestValue = ValidNicknameRequestValue(nickname: "nickname")
        do {
            // when
            let validNicknameResponse = try await sucessTestUnit.validNickname(requestValue: requestValue)
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<Bool>.self, from: dataToReturn)
            let validNicknameResult = networkResult.data
            XCTAssertEqual(validNicknameResponse, validNicknameResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_validNickname_호출시_urlParseFailed를_throw_하는지() async throws {
        // given
        let requestValue = ValidNicknameRequestValue(nickname: "nickname")
        do {
            // when
            _ = try await failureTestUnit.validNickname(requestValue: requestValue)
            // then
            XCTFail()
        } catch {
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
