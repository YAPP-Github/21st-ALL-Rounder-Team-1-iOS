//
//  CustomerSatisfactionRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/08.
//

import Foundation

@available(*, deprecated, message: "Please use AsyncRepository")
final class CustomerSatisfactionRepository: CustomerSatisfactionRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let userInfoRepository: UserInfoRepositoryInterface

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        userInfoRepository: UserInfoRepositoryInterface = UserInfoRepository()
    ) {
        self.networkService = networkService
        self.userInfoRepository = userInfoRepository
    }

    func upload(requestValue: CustomerSatisfactionRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/cs"

        if requestValue.type == .requestRegion {
            return userInfoRepository.fetchProfile { result in
                switch result {
                case .success(let user):
                    let userId = user.id
                    let dto = CustomerSatisfactionDTO(
                        userId: userId,
                        type: requestValue.type.rawValue,
                        content: requestValue.content
                    )
                    guard let requestBody = try? JSONEncoder().encode(dto) else {
                        completion(.failure(RepositoryError.requestParseFailed))
                        return
                    }

                    guard let request = urlComponents?.toURLRequest(method: .post, httpBody: requestBody) else {
                        completion(.failure(RepositoryError.urlParseFailed))
                        return
                    }

                    self.networkService.dataTask(
                        request: request
                    ) { (result: Result<CustomerSatisfactionResponseDTO, Error>) in
                        switch result {
                        case .success:
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }?.resume()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let dto = CustomerSatisfactionDTO(
                userId: requestValue.userId,
                type: requestValue.type.rawValue,
                content: requestValue.content
            )
            guard let requestBody = try? JSONEncoder().encode(dto) else {
                completion(.failure(RepositoryError.requestParseFailed))
                return nil
            }

            guard let request = urlComponents?.toURLRequest(method: .post, httpBody: requestBody) else {
                completion(.failure(RepositoryError.urlParseFailed))
                return nil
            }

            return networkService.dataTask(
                request: request
            ) { (result: Result<CustomerSatisfactionResponseDTO, Error>) in
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
