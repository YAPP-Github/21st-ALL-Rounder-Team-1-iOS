//
//  NetworkService.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation

public enum NetworkError: Error {
    case noAuthToken
    case invalidResponse(statusCode: Int)
    case sessionError
    case jsonParseFailed
    case exceptionPareFailed
    case exception(errorMessage: String)
}

extension URLSessionDataTask: Cancellable { }

protocol NetworkServiceInterface {
    var baseURL: String { get }

    func dataTask<DTO: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<DTO, Error>) -> Void
    ) -> Cancellable?
}

final class NetworkService: NetworkServiceInterface {
    static let shared = NetworkService()

    let baseURL = "https://www.pump-api-dev.com"
    private var token: String {
        guard let token = KeychainManager.shared.getItem(key: "token") as? String else {
            fatalError("There Is No JWT Token")
        }
        return token
    }

    private init() { }

    func dataTask<DTO: Decodable>(request: URLRequest, completion: @escaping (Result<DTO, Error>) -> Void) -> Cancellable? {
        var request = request
        request.addValue(token, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.sessionError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                guard let data = data, let exception = try? JSONDecoder().decode(Exception.self, from: data) else {
                    completion(.failure(NetworkError.exceptionPareFailed))
                    return
                }
                completion(.failure(NetworkError.exception(errorMessage: exception.message)))
                return
            }

            guard let data = data, let dto = try? JSONDecoder().decode(DTO.self, from: data) else {
                completion(.failure(NetworkError.jsonParseFailed))
                return
            }

            completion(.success(dto))
        }

        return task
    }
}
