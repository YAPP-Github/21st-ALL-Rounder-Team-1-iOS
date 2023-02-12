//
//  ValidNicknameUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

struct ValidNicknameRequestValue {
    let nickname: String
}

protocol ValidNicknameUseCaseInterface {
    func execute(requestValue: ValidNicknameRequestValue) async throws -> Bool
}

final class ValidNicknameUseCase: ValidNicknameUseCaseInterface {
    private let userInfoRepository: AsyncUserInfoRepositoryInterface

    init(userInfoRepository: AsyncUserInfoRepositoryInterface = AsyncUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(requestValue: ValidNicknameRequestValue) async throws -> Bool {
        return try await userInfoRepository.validNickname(requestValue: requestValue)
    }
}
