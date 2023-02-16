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
                if !UserDefaults.standard.bool(forKey: "isLookAroundUser") {
                    _ = try await signUpUseCase.execute(requestValue: requestValue)
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
