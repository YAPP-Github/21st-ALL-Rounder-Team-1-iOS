//
//  UserLevelViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/02.
//

import Foundation

final class UserLevelViewModel {

    var totalReviewCount = 0
    var userLevel: UserLevelInfo.Level = .regular

    var reloadData: (() -> Void)?

    private let fetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface
    private var userReviewsLoadTask: Cancellable?

    init(fetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface = FetchUserReviewsUseCase()) {
        self.fetchUserReviewsUseCase = fetchUserReviewsUseCase
    }

    private func fetchUserReviewCount() {
        userReviewsLoadTask = fetchUserReviewsUseCase.execute { result in
            switch result {
            case .success(let reviews):
                self.totalReviewCount = reviews.count
                self.setUpUserLevel()
                self.reloadData?()
            case .failure:
                break
            }
        }
        userReviewsLoadTask?.resume()
    }

    private func setUpUserLevel() {
        if let level = UserLevelInfo.Level.allCases.first(where: {
            $0.levelUpTriggerCount <= totalReviewCount && totalReviewCount < $0.nextLevel.levelUpTriggerCount
        }) {
            userLevel = level
        }
    }
}

extension UserLevelViewModel {
    func viewDidLoad() {
        fetchUserReviewCount()
    }
}
