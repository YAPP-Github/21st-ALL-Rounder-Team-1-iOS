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
        Task {
            do {
                try await signOutUseCase.execute()
            } catch {
                print(error)
            }
        }
    }

    func withdrawButtonDidTapped() {
        Task {
            do {
                try await withdrawUseCase.execute()
            } catch {
                print(error)
            }
        }
    }
}
