//
//  MockNetworkService.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/21.
//

import XCTest
@testable import RefillStation

final class MockNetworkService: NetworkServiceInterface {
    var baseURL: String
    var dataToReturn: Data?

    init(baseURL: String, dataToReturn: Data?) {
        self.baseURL = baseURL
        self.dataToReturn = dataToReturn
    }

    func dataTask<DTO: Decodable>(request: URLRequest) async throws -> DTO {
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                guard let data = dataToReturn,
                      let dto = try? JSONDecoder().decode(NetworkResult<DTO>.self, from: data).data else {
                    continuation.resume(throwing: NetworkError.jsonParseFailed)
                    return
                }
                continuation.resume(returning: dto)
            })
        } catch {
            throw error
        }
    }
}
