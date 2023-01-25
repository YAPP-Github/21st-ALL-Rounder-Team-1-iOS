//
//  FetchUserInfoUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol FetchUserInfoUseCaseInterface {
    func execute(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable?
}

final class FetchUserInfoUseCase: FetchUserInfoUseCaseInterface {
    private let userInfoRepository: UserInfoRepositoryInterface

    init(userInfoRepository: UserInfoRepositoryInterface) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
