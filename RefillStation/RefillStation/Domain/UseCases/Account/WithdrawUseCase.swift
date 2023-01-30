//
//  WithdrawUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol WithdrawUseCaseInterface {
    func execute(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}

final class WithdrawUseCase: WithdrawUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface = MockAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return accountRepository.withdraw { result in
            completion(result)
        }
    }
}
