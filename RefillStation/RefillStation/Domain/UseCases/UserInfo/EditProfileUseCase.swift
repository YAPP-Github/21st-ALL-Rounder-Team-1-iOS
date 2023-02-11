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
    let oldImagePath: String?
    let didImageChanged: Bool
}

protocol EditProfileUseCaseInterface {
    func execute(requestValue: EditProfileRequestValue) async throws -> User
}

final class EditProfileUseCase: EditProfileUseCaseInterface {
    private let userInfoRepository: AsyncUserInfoRepositoryInterface

    init(userInfoRepository: AsyncUserInfoRepositoryInterface = AsyncUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(requestValue: EditProfileRequestValue) async throws -> User {
        return try await userInfoRepository.editProfile(requestValue: requestValue)
    }
}
