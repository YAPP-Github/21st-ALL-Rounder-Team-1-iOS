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

    init(userInfoRepository: UserInfoRepositoryInterface = MockUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return userInfoRepository.fetchProfile { result in
            completion(result)
        }
    }
}
