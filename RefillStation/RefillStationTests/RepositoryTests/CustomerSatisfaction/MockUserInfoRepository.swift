//
//  MockUserInfoRepository.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

final class MockUserInfoRepository: AsyncUserInfoRepositoryInterface {
    func fetchProfile() async throws -> RefillStation.User {
        return User(id: 0, name: "", imageURL: "", level: .init(level: .beginner))
    }

    func editProfile(requestValue: RefillStation.EditProfileRequestValue) async throws -> RefillStation.User {
        return User(id: 0, name: "", imageURL: "", level: .init(level: .beginner))
    }

    func validNickname(requestValue: RefillStation.ValidNicknameRequestValue) async throws -> Bool {
        return true
    }

    func fetchUserReviews() async throws -> [RefillStation.Review] {
        return []
    }

}
