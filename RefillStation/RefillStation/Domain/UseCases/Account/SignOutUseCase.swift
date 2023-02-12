//
//  SignOutUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol SignOutUseCaseInterface {
    func execute() async throws
}

final class SignOutUseCase: SignOutUseCaseInterface {
    private let accountRepository: AsyncAccountRepositoryInterface

    init(accountRepository: AsyncAccountRepositoryInterface = AsyncAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute() async throws {
        try await accountRepository.signOut()
    }
}
