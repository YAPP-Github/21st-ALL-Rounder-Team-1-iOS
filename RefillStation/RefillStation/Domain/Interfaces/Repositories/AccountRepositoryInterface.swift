//
//  AccountRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol AccountRepositoryInterface {
    func OAuthLogin(loginType: OAuthType,
                    requestValue: OAuthLoginRequestValue,
                    completion: @escaping (Result<OAuthLoginResponseValue, Error>) -> Void) -> Cancellable?
    func signUp(requestValue: SignUpRequestValue,
                completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    func withdraw(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
    func createNickname(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}
