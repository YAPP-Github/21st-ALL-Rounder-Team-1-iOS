//
//  RegisterReviewRepositoryInterface.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol RegisterReviewRepositoryInterface {
    func fetchTags(completion: @escaping(Result<[Tag], Error>) -> Void) -> Cancellable?
    func registerReview(query: RegiserReviewRequestValue,
                        completion: @escaping (Result<Never, Error>) -> Void) -> Cancellable?
    func uploadReviewImage(query: UploadImageRequestValue,
                           completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable?
}
