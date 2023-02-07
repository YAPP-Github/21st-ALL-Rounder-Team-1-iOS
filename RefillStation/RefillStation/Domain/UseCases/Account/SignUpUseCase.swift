//
//  SignUpUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

struct SignUpRequestValue {
    let name: String
    let email: String
    let imagePath: String
    let oauthType: String
    let oauthIdentity: String
}

struct SignUpResponseValue {
    let jwt: String
}

protocol SignUpUseCaseInterface {
    func execute(requestValue: SignUpRequestValue,
                 completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}

final class SignUpUseCase: SignUpUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface = MockAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute(requestValue: SignUpRequestValue,
                 completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        return accountRepository.signUp(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
