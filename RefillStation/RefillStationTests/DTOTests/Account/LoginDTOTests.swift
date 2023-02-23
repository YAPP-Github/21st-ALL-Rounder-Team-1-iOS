//
//  LoginDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

final class LoginDTOTests: XCTestCase {
    var fullContentUnit: LoginDTO!
    var minimumContentUnit: LoginDTO!

    override func setUpWithError() throws {
        fullContentUnit = LoginDTO(name: "name", email: "email", imgPath: "imgPath", oauthType: "oauthType", oauthIdentity: "oauthIdentity", jwt: "jwt", refreshToken: "refreshToken")
        minimumContentUnit = LoginDTO(name: nil, email: nil, imgPath: nil, oauthType: nil, oauthIdentity: nil, jwt: nil, refreshToken: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_LoginDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_OAuthLoginResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toDomain()
        // then
        let expectationResult = OAuthLoginResponseValue(name: "name", email: "email", imgPath: "imgPath", oauthIdentity: "oauthIdentity", oauthType: "oauthType", jwt: "jwt", refreshToken: "refreshToken")
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_LoginDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_OAuthLoginResponseValue를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toDomain()
        // then
        let expectationResult = OAuthLoginResponseValue(name: nil, email: nil, imgPath: nil, oauthIdentity: "", oauthType: "", jwt: nil, refreshToken: "")
        XCTAssertEqual(domainResult, expectationResult)
    }
}
