//
//  UserInfoRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol UserInfoRepositoryInterface {
    func fetchProfile(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
    func editProfile(requestValue: EditProfileRequestValue, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
    func validNickname(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func fetchUserReviews(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable?
}
