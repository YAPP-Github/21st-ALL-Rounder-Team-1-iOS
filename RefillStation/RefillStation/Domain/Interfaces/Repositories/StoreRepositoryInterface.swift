//
//  StoreRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/26.
//

import Foundation

protocol StoreRepositoryInterface {
    func fetchStores(requestValue: FetchStoresUseCaseRequestValue,
                     completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
    func fetchProducts(requestValue: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable?
    func fetchStoreReviews(requestValue: FetchStoreReviewsRequestValue, completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable?
    func recommendStore(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable?
}
