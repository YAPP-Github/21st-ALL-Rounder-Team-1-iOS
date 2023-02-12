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

    var presentToLogin: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    init(signOutUseCase: SignOutUseCase, withdrawUseCase: WithdrawUseCase) {
        self.signOutUseCase = signOutUseCase
        self.withdrawUseCase = withdrawUseCase
    }

    func signOutButtonDidTapped() {
        Task {
            do {
                try await signOutUseCase.execute()
                presentToLogin?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }

    func withdrawButtonDidTapped() {
        Task {
            do {
                try await withdrawUseCase.execute()
                presentToLogin?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }
}
