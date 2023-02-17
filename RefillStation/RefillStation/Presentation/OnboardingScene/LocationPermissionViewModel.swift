//
//  LocationPermissionViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/02/06.
//

import Foundation

final class LocationPermissionViewModel {
    private let signUpUseCase: SignUpUseCaseInterface
    private let requestValue: SignUpRequestValue
    var isSignUpCompleted: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    init(signUpUseCase: SignUpUseCaseInterface = SignUpUseCase(),
         requestValue: SignUpRequestValue) {
        self.signUpUseCase = signUpUseCase
        self.requestValue = requestValue
    }

    func agreeButtonDidTapped() {
        Task {
            do {
                if (KeychainManager.shared.getItem(key: "token") == nil
                    && KeychainManager.shared.getItem(key: "lookAroundToken") == nil)
                    || UserDefaults.standard.bool(forKey: "didLookAroundLoginStarted") {
                    _ = try await signUpUseCase.execute(requestValue: requestValue)
                    UserDefaults.standard.setValue(false, forKey: "didLookAroundLoginStarted")
                }
                self.isSignUpCompleted?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }
}
