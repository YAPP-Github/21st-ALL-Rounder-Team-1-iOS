//
//  AsyncCustomerSatisfactionRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

final class AsyncCustomerSatisfactionRepository: AsyncCustomerSatisfactionRepositoryInterface {
    private let networkService: NetworkServiceInterface
    private let userInfoRepository: AsyncUserInfoRepositoryInterface

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        userInfoRepository: AsyncUserInfoRepositoryInterface = AsyncUserInfoRepository()
    ) {
        self.networkService = networkService
        self.userInfoRepository = userInfoRepository
    }

    func upload(requestValue: CustomerSatisfactionRequestValue) async throws {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/cs"
        let userId = requestValue.type == .reportUser ? requestValue.userId
        : try await userInfoRepository.fetchProfile().id

        let dto = CustomerSatisfactionDTO(
            userId: userId,
            type: requestValue.type.rawValue,
            content: requestValue.content
        )
        guard let requestBody = try? JSONEncoder().encode(dto) else {
            throw RepositoryError.requestParseFailed
        }

        guard let request = urlComponents?.toURLRequest(method: .post, httpBody: requestBody) else {
            throw RepositoryError.urlParseFailed
        }

        let _: CustomerSatisfactionResponseDTO = try await networkService.dataTask(request: request)
        if requestValue.type == .requestRegion {
            UserDefaults.standard.setValue(true, forKey: "didRequestRegion")
        }
    }
}
