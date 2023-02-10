//
//  AsyncAccountRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

protocol AsyncAccountRepositoryInterface {
    func OAuthLogin(loginType: OAuthType, requestValue: OAuthLoginRequestValue) async throws -> OAuthLoginResponseValue
    func signUp(requestValue: SignUpRequestValue) async throws -> String
    func signOut() async throws
    func withdraw() async throws
    func createNickname() async throws -> String
}
