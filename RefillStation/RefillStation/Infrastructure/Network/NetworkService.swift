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
    case exceptionParseFailed
    case exception(errorMessage: String)
}

protocol NetworkServiceInterface {
    var baseURL: String { get }
    func dataTask<DTO: Decodable>(request: URLRequest) async throws -> DTO
}

final class NetworkService: NetworkServiceInterface {
    static let shared = NetworkService()

    let baseURL = "https://www.pump-api-dev.com"
    private var token: String? {
        if let token = KeychainManager.shared.getItem(key: "token") as? String {
            return token
        } else if let lookAroundToken = KeychainManager.shared.getItem(key: "lookAroundToken") as? String {
            return lookAroundToken
        }
        return nil
    }

    private init() { }

    func dataTask<DTO: Decodable>(request: URLRequest) async throws -> DTO {
        var request = request
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("There is no jwt token")
        }
        if #available(iOS 15, *) {
            let (data, response) = try await URLSession.shared.data(for: request)
            print("🌐 " + (request.httpMethod ?? "") + " : " + String(request.url?.absoluteString ?? ""))
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                guard let exception = try? JSONDecoder().decode(Exception.self, from: data) else {
                    print("🚨 data: " + (String(data: data, encoding: .utf8) ?? ""))
                    throw NetworkError.exceptionParseFailed
                }
                print("🚨 status: \(exception.status) \n message: \(exception.message)")
                throw NetworkError.exception(errorMessage: exception.message)
            }

            guard let dto = try? JSONDecoder().decode(NetworkResult<DTO>.self, from: data).data else {
                throw NetworkError.jsonParseFailed
            }
            print("✅ status: \(httpResponse.statusCode)")
            return dto
        } else {
            return try await withCheckedThrowingContinuation({ continuation in
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if error != nil {
                        continuation.resume(throwing: NetworkError.sessionError)
                        return
                    }
                    print("🌐 request: " + String(response?.url?.absoluteString ?? ""))
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        guard let data = data,
                              let exception = try? JSONDecoder().decode(Exception.self, from: data) else {
                            continuation.resume(throwing: NetworkError.exceptionParseFailed)
                            print("🚨 data: " + (String(data: data!, encoding: .utf8) ?? ""))
                            return
                        }
                        continuation.resume(throwing: NetworkError.exception(errorMessage: exception.message))
                        print("🚨 status: \(exception.status) \n message: \(exception.message)")
                        return
                    }

                    guard let data = data,
                          let dto = try? JSONDecoder().decode(NetworkResult<DTO>.self, from: data).data else {
                        continuation.resume(throwing: NetworkError.jsonParseFailed)
                        return
                    }
                    print("✅ status: \(httpResponse.statusCode)")
                    continuation.resume(returning: dto)
                }.resume()
            })
        }
    }
}
