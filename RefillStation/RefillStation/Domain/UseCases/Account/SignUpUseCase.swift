//
//  SignUpUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

struct SignUpRequestValue {
    let name: String?
    let email: String?
    let imagePath: String?
    let oauthType: String
    let oauthIdentity: String
}

struct SignUpResponseValue {
    let jwt: String
}

protocol SignUpUseCaseInterface {
    func execute(requestValue: SignUpRequestValue) async throws -> String
}

final class SignUpUseCase: SignUpUseCaseInterface {
    private let accountRepository: AsyncAccountRepositoryInterface

    init(accountRepository: AsyncAccountRepositoryInterface = AsyncAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute(requestValue: SignUpRequestValue) async throws -> String {
        return try await accountRepository.signUp(requestValue: requestValue)
    }
}
