//
//  MockRepositories.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import Foundation

final class MockHomeRepository: HomeRepositoryInterface {
    func fetchStoreList(query: FetchStoreListUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }

    func searchStoreList(query: SearchStoreListUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}

final class MockProductListRepository: ProductListRepositoryInterface {
    func fetchProductList(query: FetchProductListRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable {
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

    func uploadReviewImage(query: UploadReviewImageRequestValue, completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}
