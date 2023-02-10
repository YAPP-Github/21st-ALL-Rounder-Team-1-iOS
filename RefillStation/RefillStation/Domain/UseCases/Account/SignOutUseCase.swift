//
//  SignOutUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol SignOutUseCaseInterface {
    func execute(completion: @escaping (Result<Void, Error>) -> Void)
}

final class SignOutUseCase: SignOutUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface = MockAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute(completion: @escaping (Result<Void, Error>) -> Void) {
        accountRepository.signOut { result in
            completion(result)
        }
    }
}
