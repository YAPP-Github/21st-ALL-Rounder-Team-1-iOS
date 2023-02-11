//
//  WithdrawUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol WithdrawUseCaseInterface {
    func execute() async throws
}

final class WithdrawUseCase: WithdrawUseCaseInterface {
    private let accountRepository: AsyncAccountRepositoryInterface

    init(accountRepository: AsyncAccountRepositoryInterface = AsyncAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute() async throws {
        try await accountRepository.withdraw()
    }
}
