//
//  AccountManagementViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/02/08.
//

import Foundation

final class AccountManagementViewModel {
    private let signOutUseCase: SignOutUseCase
    private let withdrawUseCase: WithdrawUseCase

    var signOutTask: Cancellable?
    var withdrawTask: Cancellable?

    var presentToLogin: (() -> Void)?

    init(signOutUseCase: SignOutUseCase, withdrawUseCase: WithdrawUseCase) {
        self.signOutUseCase = signOutUseCase
        self.withdrawUseCase = withdrawUseCase
    }

    func signOutButtonDidTapped() {
        signOutUseCase.execute(completion: { result in
            switch result {
            case .success:
                self.presentToLogin?()
            case .failure(let failure):
                return
            }
        })
    }

    func withdrawButtonDidTapped() {
        withdrawTask = withdrawUseCase.execute(completion: { result in
            switch result {
            case .success:
                self.presentToLogin?()
            case .failure(let failure):
                return
            }
        })
        withdrawTask?.resume()
    }
}
