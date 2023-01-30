//
//  EditProfileUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

struct EditProfileRequestValue {
    let name: String
    let nickname: String
    let email: String
    let phoneNumber: String
    let type: String
    let oauthType: String
    let oauthIdentity: String
    let rating: Int
    let imgPath: String
}

protocol EditProfileUseCaseInterface {
    func execute(requestValue: EditProfileRequestValue, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

final class EditProfileUseCase: EditProfileUseCaseInterface {
    private let userInfoRepository: UserInfoRepositoryInterface

    init(userInfoRepository: UserInfoRepositoryInterface = MockUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(requestValue: EditProfileRequestValue, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return userInfoRepository.editProfile(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
