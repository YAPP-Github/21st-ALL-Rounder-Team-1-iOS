//
//  AccountRepository.swift
//  RefillStation
//
//  Created by kong on 2023/02/05.
//

import Foundation

final class AccountRepository: AccountRepositoryInterface {
    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    func OAuthLogin(loginType: OAuthType,
                    requestValue: OAuthLoginRequestValue,
                    completion: @escaping (Result<OAuthLoginResponseValue, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/login/oauth/\(loginType.path)"
        urlComponents?.queryItems = [
            URLQueryItem(name: "accessToken", value: String(requestValue.accessToken))
        ]
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<LoginDTO, Error>) in
            switch result {
            case .success(let loginDTO):
                if let token = loginDTO.jwt {
                    if !KeychainManager.shared.updateItem(key: "token", value: token) {
                        _ = KeychainManager.shared.addItem(key: "token", value: token)
                    }
                }
                completion(.success(loginDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func signUp(requestValue: SignUpRequestValue, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/register"
        guard let requestBody = try? JSONEncoder().encode(
            SignUpReqeustDTO(name: requestValue.name,
                             email: requestValue.email,
                             imagePath: requestValue.imagePath,
                             oauthType: requestValue.oauthType,
                             oauthIdentity: requestValue.oauthIdentity)
        ) else {
            completion(.failure(RepositoryError.requestParseFailed))
            return nil
        }
        guard let request = urlComponents?.toURLRequest(method: .post, httpBody: requestBody) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<String, Error>) in
            switch result {
            case .success(let token):
                _ = KeychainManager.shared.addItem(key: "token", value: token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func withdraw(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return nil
    }

    func createNickname(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        return nil
    }
}