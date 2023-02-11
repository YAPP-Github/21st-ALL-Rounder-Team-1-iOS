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
    var userId: Int?
    var userNickname: String?
    var userLevel: UserLevelInfo?
    var userRank: UserLevelInfo.Level?
    var profileImage: String?

    init(fetchUserInfoUseCase: FetchUserInfoUseCaseInterface = FetchUserInfoUseCase()) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }

    private func fetchUserInfo() {
        userInfoLoadTask = Task {
            do {
                let userInfo = try await fetchUserInfoUseCase.execute()
                userId = userInfo.id
                userNickname = userInfo.name
                userLevel = userInfo.level
                userRank = userInfo.level.level
                profileImage = userInfo.imageURL
                setUpContents?()
            } catch {
                print(error)
            }
        }
    }

    func appVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return "" }
        return "V \(version)"
    }
}

extension MyPageViewModel {
    func viewWillApeear() {
        fetchUserInfo()
    }

    func viewWillDisappear() {
        userInfoLoadTask?.cancel()
    }
}
