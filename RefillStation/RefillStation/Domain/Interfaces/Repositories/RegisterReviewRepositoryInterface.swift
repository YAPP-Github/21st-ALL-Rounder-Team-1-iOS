//
//  RegisterReviewRepositoryInterface.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol RegisterReviewRepositoryInterface {
    func registerReview(query: RegiserReviewRequestValue,
                        completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}
