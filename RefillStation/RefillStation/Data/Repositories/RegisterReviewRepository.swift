//
//  RegisterReviewRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

final class RegisterReviewRepository: RegisterReviewRepositoryInterface {
    private let networkService: NetworkService
    private let cache: TagResponseStorage

    init(networkService: NetworkService, cache: TagResponseStorage) {
        self.networkService = networkService
        self.cache = cache
    }

    func fetchTags(completion: @escaping (Result<[Tag], Error>) -> Void) -> Cancellable? {
        return nil
    }

    func registerReview(query: RegiserReviewRequestValue,
                        completion: @escaping (Result<Never, Error>) -> Void) -> Cancellable? {
        return nil
    }

    func uploadReviewImage(query: UploadReviewImageRequestValue,
                           completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
