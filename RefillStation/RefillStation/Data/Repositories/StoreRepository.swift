//
//  StoreRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

final class StoreRepository: StoreRepositoryInterface {

    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
    }

    func fetchStores(requestValue: FetchStoresUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        let path = "/api/user/\(requestValue.longitude)/\(requestValue.latitude)/stores"
        guard let request = urlRequest(method: .get, path: path) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }

        return networkService.dataTask(request: request) { (result: Result<[StoreDTO], Error>) in
            switch result {
            case .success(let storeDTOs):
                completion(.success(storeDTOs.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchProducts(requestValue: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable? {
        let path = "/api/\(requestValue.storeId)/items"
        guard let request = urlRequest(method: .get, path: path) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<[ProductDTO], Error>) in
            switch result {
            case .success(let productDTOs):
                completion(.success(productDTOs.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchStoreReviews(requestValue: FetchStoreReviewsRequestValue, completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        let path = "/api/\(requestValue.storeId)/reviews"
        guard let request = urlRequest(method: .get, path: path) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<[ReviewDTO], Error>) in
            switch result {
            case .success(let reviewDTOs):
                completion(.success(reviewDTOs.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func recommendStore(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable? {
        let path = "/api/recommendation"
        let method: HTTPMethod = requestValue.type == .recommend ? .post : .delete
        guard var request = urlRequest(method: method, path: path) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        guard let requestBody = try? JSONEncoder()
            .encode(StoreRecommendRequestDTO(storeId: requestValue.storeId)) else {
            completion(.failure(RepositoryError.requestParseFailed))
            return nil
        }
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return networkService.dataTask(request: request) { (result: Result<StoreRecommendDTO, Error>) in
            switch result {
            case .success(let storeRecommendDTO):
                completion(.success(storeRecommendDTO.toResponseValue()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func urlRequest(method: HTTPMethod, path: String) -> URLRequest? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = path

        guard let url = urlComponents?.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.name

        return urlRequest
    }
}
