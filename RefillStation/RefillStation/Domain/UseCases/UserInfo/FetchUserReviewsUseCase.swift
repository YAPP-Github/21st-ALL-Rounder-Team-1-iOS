//
//  FetchUserReviewsUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol FetchUserReviewsUseCaseInterface {
    func execute() async throws -> [Review]
}

final class FetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface {
    private let userInfoRepository: AsyncUserInfoRepositoryInterface

    init(userInfoRepository: AsyncUserInfoRepositoryInterface = AsyncUserInfoRepository()) {
        self.userInfoRepository = userInfoRepository
    }

    func execute() async throws -> [Review] {
        return try await userInfoRepository.fetchUserReviews()
    }
}
