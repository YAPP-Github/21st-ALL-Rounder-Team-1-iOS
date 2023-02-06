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
    private var signUpTask: Cancellable?
    var isSignUpCompleted: (() -> Void)?

    init(signUpUseCase: SignUpUseCaseInterface,
         requestValue: SignUpRequestValue) {
        self.signUpUseCase = signUpUseCase
        self.requestValue = requestValue
    }

    func agreeButtonDidTapped() {
        signUpTask = signUpUseCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let token):
                _ = KeychainManager.shared.updateItem(key: "token", value: token)
                DispatchQueue.main.async {
                    self.isSignUpCompleted?()
                }
            case .failure(let failure):
                return
            }
        }
        signUpTask?.resume()
    }
}
