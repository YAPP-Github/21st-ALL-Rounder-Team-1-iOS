//
//  AsyncRegisterReviewRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

protocol AsyncRegisterReviewRepositoryInterface {
    func registerReview(query: RegiserReviewRequestValue) async throws
}
