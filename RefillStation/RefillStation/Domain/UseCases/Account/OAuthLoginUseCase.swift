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
    var path: String {
        switch self {
        case .apple:
            return "apple"
        case .kakao:
            return "kakao"
        case .naver:
            return "naver"
        }
    }
}

struct OAuthLoginRequestValue {
    let accessToken: String
}

struct OAuthLoginResponseValue {
    let name: String
    let email: String
    let imgPath: String
    let oauthIdentity: String
    let oauthType: String
    let jwt: String?
    let refreshToken: String
}

protocol OAuthLoginUseCaseInterface {
    func execute(loginType: OAuthType,
                 requestValue: OAuthLoginRequestValue,
                 completion: @escaping (Result<OAuthLoginResponseValue, Error>) -> Void) -> Cancellable?
}

final class OAuthLoginUseCase: OAuthLoginUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface = MockAccountRepository()) {
        self.accountRepository = accountRepository
    }
    func execute(loginType: OAuthType,
                 requestValue: OAuthLoginRequestValue,
                 completion: @escaping (Result<OAuthLoginResponseValue, Error>) -> Void) -> Cancellable? {
        return accountRepository.OAuthLogin(loginType: loginType,
                                            requestValue: requestValue) { result in
            completion(result)
        }
    }
}
