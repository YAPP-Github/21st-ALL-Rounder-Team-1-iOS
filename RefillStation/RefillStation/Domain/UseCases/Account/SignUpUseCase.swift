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
    let OAuthIdentity: String
}

protocol SignUpUseCaseInterface {
    func execute(requestValue: SignUpRequestValue,
                 completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}

final class SignUpUseCase: SignUpUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface) {
        self.accountRepository = accountRepository
    }

    func execute(requestValue: SignUpRequestValue,
                 completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
