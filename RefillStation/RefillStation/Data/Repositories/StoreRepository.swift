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
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.queryItems = [
            .init(name: "longitude", value: String(requestValue.longitude)),
            .init(name: "latitude", value: String(requestValue.latitude))
        ]
        urlComponents?.path = "/api/user/stores"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
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
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/items"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
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
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/reviews"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
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

    func fetchStoreRecommend(requestValue: FetchStoreRecommendRequestValue, completion: @escaping (Result<FetchStoreRecommendResponseValue, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/recommendation"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<FetchStoreRecommendDTO, Error>) in
            switch result {
            case .success(let fetchStoreRecommendDTO):
                completion(.success(fetchStoreRecommendDTO.toResponseValue()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func recommendStore(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/recommendation"
        guard let requestBody = try? JSONEncoder()
            .encode(StoreRecommendRequestDTO(storeId: requestValue.storeId)) else {
            completion(.failure(RepositoryError.requestParseFailed))
            return nil
        }
        guard let request = urlComponents?.toURLRequest(
            method: requestValue.type == .recommend ? .post : .delete,
            httpBody: requestBody
        ) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }
        return networkService.dataTask(request: request) { (result: Result<StoreRecommendDTO, Error>) in
            switch result {
            case .success(let storeRecommendDTO):
                completion(.success(storeRecommendDTO.toResponseValue()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
