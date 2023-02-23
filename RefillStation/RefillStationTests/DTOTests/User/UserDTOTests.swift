//
//  UserDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class UserDTOTests: XCTestCase {
    var fullContentUnit: UserDTO!
    var minimumContentUnit: UserDTO!

    override func setUpWithError() throws {
        fullContentUnit = UserDTO(createdAt: "createdAt", modifiedAt: "modifiedAt", id: 1, name: "name", nickname: "nickname", email: "email", phoneNumber: "phoneNumber", type: "type", oauthType: "oauthType", oauthIdentity: "oauthIdentity", rating: 2, imgPath: "imgPath")
        minimumContentUnit = UserDTO(createdAt: nil, modifiedAt: nil, id: nil, name: nil, nickname: nil, email: nil, phoneNumber: nil, type: nil, oauthType: nil, oauthIdentity: nil, rating: nil, imgPath: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_UserDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_User를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toDomain()
        // then
        let expectationResult = User(id: 1, name: "nickname", imageURL: "imgPath", level: .init(level: .beginner))
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_UserDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_User를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toDomain()
        // then
        let expectationResult = User(id: 0, name: "", imageURL: nil, level: .init(level: .regular))
        XCTAssertEqual(domainResult, expectationResult)
    }
}

