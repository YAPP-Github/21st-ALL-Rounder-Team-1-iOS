//
//  EditProfileUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import UIKit

struct EditProfileRequestValue {
    let nickname: String
    let rating: Int
    let newImage: UIImage?
    let oldImagePath: String
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
