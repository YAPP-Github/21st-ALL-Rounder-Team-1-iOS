//
//  FetchUserReviewsUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol FetchUserReviewsUseCaseInterface {
    func execute(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable?
}

final class FetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface {
    private let userInfoRepository: UserInfoRepositoryInterface

    init(userInfoRepository: UserInfoRepositoryInterface = MockUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        return userInfoRepository.fetchUserReviews { result in
            completion(result)
        }
    }
}
