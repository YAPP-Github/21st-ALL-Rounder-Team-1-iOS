//
//  MyPageViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import Foundation

final class MyPageViewModel {
    private let fetchUserInfoUseCase: FetchUserInfoUseCaseInterface
    private var userInfoLoadTask: Cancellable?

    var setUpContents: (() -> Void)?
    var userNickname: String?
    var userRank: UserLevelInfo.Level?
    var profileImage: String?

    init(fetchUserInfoUseCase: FetchUserInfoUseCaseInterface = FetchUserInfoUseCase()) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }

    private func fetchUserInfo() {
        userInfoLoadTask = fetchUserInfoUseCase.execute(completion: { result in
            switch result {
            case .success(let userInfo):
                self.userNickname = userInfo.name
                self.userRank = userInfo.level.level
                self.profileImage = userInfo.imageURL
                self.setUpContents?()
            case .failure(let error):
                break
            }
        })
        userInfoLoadTask?.resume()
    }
}

extension MyPageViewModel {
    func viewWillApeear() {
        fetchUserInfo()
    }
}
