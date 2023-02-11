//
//  CreateNicknameUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol CreateNicknameUseCaseInterface {
    func execute() async throws -> String
}

final class CreateNicknameUseCase: CreateNicknameUseCaseInterface {
    private let accountRepository: AsyncAccountRepositoryInterface

    init(accountRepository: AsyncAccountRepositoryInterface = AsyncAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute() async throws -> String {
        return try await accountRepository.createNickname()
    }
}
