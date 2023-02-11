//
//  FetchUserInfoUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol FetchUserInfoUseCaseInterface {
    func execute() async throws -> User
}

final class FetchUserInfoUseCase: FetchUserInfoUseCaseInterface {
    private let userInfoRepository: AsyncUserInfoRepositoryInterface

    init(userInfoRepository: AsyncUserInfoRepositoryInterface = AsyncUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute() async throws -> User {
        return try await userInfoRepository.fetchProfile()
    }
}
