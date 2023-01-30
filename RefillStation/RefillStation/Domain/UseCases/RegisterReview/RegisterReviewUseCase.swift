//
//  RegisterReviewUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct RegiserReviewRequestValue {
    let storeId: Int
    let tagIds: [Int]
    let imageURLs: [String]
    let description: String
}

protocol RegisterReviewUseCaseInterface {
    func execute(requestValue: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}

final class RegisterReviewUseCase: RegisterReviewUseCaseInterface {

    private let registerReviewRepository: RegisterReviewRepositoryInterface

    init(registerReviewRepository: RegisterReviewRepositoryInterface = MockRegisterReviewRepository()) {
        self.registerReviewRepository = registerReviewRepository
    }

    func execute(requestValue: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return registerReviewRepository.registerReview(query: requestValue) { result in
            completion(result)
        }
    }
}
