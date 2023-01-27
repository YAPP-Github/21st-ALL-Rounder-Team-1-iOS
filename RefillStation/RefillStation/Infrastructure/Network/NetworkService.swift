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
    case noData
}

extension URLSessionDataTask: Cancellable { }

protocol NetworkServiceInterface {
    func dataTask(
        request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable?
}

final class NetworkService: NetworkServiceInterface {
    static let shared = NetworkService()

    private init() { }

    func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        var request = request
        guard let token = KeychainManager.shared.getItem(key: "token") as? String else {
            completion(.failure(NetworkError.noAuthToken))
            return nil
        }
        request.addValue(token, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.sessionError))
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode

            guard self.isValidResponse(response) else {
                completion(.failure(NetworkError.invalidResponse(statusCode: statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }

        return task
    }

    private func isValidResponse(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return false
        }

        return true
    }
}
