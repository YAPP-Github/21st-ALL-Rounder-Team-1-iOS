//
//  AsyncStoreRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

protocol AsyncStoreRepositoryInterface {
    func fetchStores(requestValue: FetchStoresUseCaseRequestValue) async throws -> [Store]
    func fetchProducts(requestValue: FetchProductsRequestValue) async throws -> [Product]
    func fetchStoreReviews(requestValue: FetchStoreReviewsRequestValue) async throws -> [Review]
    func fetchStoreRecommend(requestValue: FetchStoreRecommendRequestValue) async throws -> FetchStoreRecommendResponseValue
    func recommendStore(requestValue: RecommendStoreRequestValue) async throws -> RecommendStoreResponseValue
}
