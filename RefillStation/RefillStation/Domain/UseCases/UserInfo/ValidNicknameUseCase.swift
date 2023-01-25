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
    func execute(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
}

final class ValidNicknameUseCase: ValidNicknameUseCaseInterface {
    private let userInfoRepository: UserInfoRepositoryInterface

    init(userInfoRepository: UserInfoRepositoryInterface) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
