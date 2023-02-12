//
//  AsyncUserInfoRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

protocol AsyncUserInfoRepositoryInterface {
    func fetchProfile() async throws -> User
    func editProfile(requestValue: EditProfileRequestValue) async throws -> User
    func validNickname(requestValue: ValidNicknameRequestValue) async throws -> Bool
    func fetchUserReviews() async throws -> [Review]
}
