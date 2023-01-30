//
//  OAuthLoginUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

enum OAuthType {
    case apple
    case kakao
    case naver
}

protocol OAuthLoginUseCaseInterface {
    func execute(loginType: OAuthType, completion: @escaping (Result<String?, Error>) -> Void) -> Cancellable?
}

final class OAuthLoginUseCase {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface = MockAccountRepository()) {
        self.accountRepository = accountRepository
    }

    func execute(loginType: OAuthType, completion: @escaping (Result<String?, Error>) -> Void) -> Cancellable? {
        return accountRepository.OAuthLogin(loginType: loginType) { result in
            completion(result)
        }
    }
}
