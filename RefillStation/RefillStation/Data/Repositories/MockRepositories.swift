//
//  MockRepositories.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import Foundation

final class MockHomeRepository: HomeRepositoryInterface {
    func fetchStoreList(query: FetchStoresUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}

final class MockProductsRepository: ProductsRepositoryInterface {
    func fetchProducts(query: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}

final class MockStoreReviewRepository: StoreReviewRepositoryInterface {

}

final class MockRequestRegionRepository: RequestRegionRepositoryInterface {

}

final class MockRegisterReviewRepository: RegisterReviewRepositoryInterface {
    func fetchTags(completion: @escaping (Result<[Tag], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }

    func registerReview(query: RegiserReviewRequestValue, completion: @escaping (Result<Never, Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }

    func uploadReviewImage(query: UploadImageRequestValue, completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}
