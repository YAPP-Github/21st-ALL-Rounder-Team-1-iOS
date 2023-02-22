//
//  OAuthLoginTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

extension OAuthLoginResponseValue: Equatable {
    public static func == (lhs: OAuthLoginResponseValue, rhs: OAuthLoginResponseValue) -> Bool {
        return lhs.email == rhs.email
        && lhs.imgPath == rhs.imgPath
        && lhs.jwt == rhs.jwt
        && lhs.name == rhs.name
        && lhs.oauthIdentity == rhs.oauthIdentity
        && lhs.oauthType == rhs.oauthType
        && lhs.refreshToken == rhs.refreshToken
    }
}

class OAuthLoginTest: XCTestCase {

    var sucessTestUnit: AsyncAccountRepository!
    var failureTestUnit: AsyncAccountRepository!
    let dataToReturn =
"""
{
    "message":"로그인 성공",
    "status":200,
    "data":{
        "name":null,
        "email":null,
        "imgPath":null,
        "oauthIdentity":"",
        "jwt":"",
        "refreshToken":null
    }
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
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL과_apple_loginType으로_OAuthLogin_호출시_OAuthLoginResponseValue를_반환하는지() async throws {
        // given
        let dummyAccessToken = ""

        do {
            // when
            let OAuthLoginResponse = try await sucessTestUnit.OAuthLogin(
                loginType: .apple,
                requestValue: .init(accessToken: dummyAccessToken)
            )
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<LoginDTO>.self, from: dataToReturn)
            let OAuthLoginResult = networkResult.data.toDomain()
            XCTAssertEqual(OAuthLoginResponse, OAuthLoginResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_올바른_baseURL과_kakao_loginType으로_OAuthLogin_호출시_OAuthLoginResponseValue를_반환하는지() async throws {
        // given
        let dummyAccessToken = ""

        do {
            // when
            let OAuthLoginResponse = try await sucessTestUnit.OAuthLogin(
                loginType: .kakao,
                requestValue: .init(accessToken: dummyAccessToken)
            )
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<LoginDTO>.self, from: dataToReturn)
            let OAuthLoginResult = networkResult.data.toDomain()
            XCTAssertEqual(OAuthLoginResponse, OAuthLoginResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_올바른_baseURL과_lookAround_loginType으로_OAuthLogin_호출시_OAuthLoginResponseValue를_반환하는지() async throws {
        // given
        let dummyAccessToken = ""

        do {
            // when
            let OAuthLoginResponse = try await sucessTestUnit.OAuthLogin(
                loginType: .lookAround,
                requestValue: .init(accessToken: dummyAccessToken)
            )
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<LoginDTO>.self, from: dataToReturn)
            let OAuthLoginResult = networkResult.data.toDomain()
            XCTAssertEqual(OAuthLoginResponse, OAuthLoginResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_OAuthLogin_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let dummyAccessToken = ""

        do {
            // when
            _ = try await failureTestUnit.OAuthLogin(
                loginType: .apple,
                requestValue: .init(accessToken: dummyAccessToken)
            )
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}

