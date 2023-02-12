//
//  AsyncStoreRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

final class AsyncStoreRepository: AsyncStoreRepositoryInterface {

    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
    }

    func fetchStores(requestValue: FetchStoresUseCaseRequestValue) async throws -> [Store] {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.queryItems = [
            .init(name: "longitude", value: String(requestValue.longitude)),
            .init(name: "latitude", value: String(requestValue.latitude))
        ]
        urlComponents?.path = "/api/user/stores"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }

        let storeDTOs: [StoreDTO] = try await networkService.dataTask(request: request)
        return storeDTOs.map { $0.toDomain() }
    }

    func fetchProducts(requestValue: FetchProductsRequestValue) async throws -> [Product] {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/items"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }
        let productDTOs: [ProductDTO] = try await networkService.dataTask(request: request)
        return productDTOs.map { $0.toDomain() }
    }

    func fetchStoreReviews(requestValue: FetchStoreReviewsRequestValue) async throws -> [Review] {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/reviews"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }
        let reviewDTOs: [ReviewDTO] = try await networkService.dataTask(request: request)
        return reviewDTOs.map { $0.toDomain() }
    }

    func fetchStoreRecommend(requestValue: FetchStoreRecommendRequestValue) async throws -> FetchStoreRecommendResponseValue {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/\(requestValue.storeId)/recommendation"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }
        let recommendDTO: FetchStoreRecommendDTO = try await networkService.dataTask(request: request)
        return recommendDTO.toResponseValue()
    }

    func recommendStore(requestValue: RecommendStoreRequestValue) async throws -> RecommendStoreResponseValue {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/recommendation"
        guard let requestBody = try? JSONEncoder()
            .encode(StoreRecommendRequestDTO(storeId: requestValue.storeId)) else {
            throw RepositoryError.requestParseFailed
        }
        guard let request = urlComponents?.toURLRequest(
            method: requestValue.type == .recommend ? .post : .delete,
            httpBody: requestBody
        ) else {
            throw RepositoryError.urlParseFailed
        }
        let recommendDTO: StoreRecommendDTO = try await networkService.dataTask(request: request)
        return recommendDTO.toResponseValue()
    }
}
