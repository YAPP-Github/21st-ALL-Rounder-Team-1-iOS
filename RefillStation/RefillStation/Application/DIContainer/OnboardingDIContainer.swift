//
//  OnboardingDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation
import UIKit

final class OnboardingDIContainer: DIContainer {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func makeOnboardingCoordinator() {

    }

    // MARK: - Onboarding
    func makeOnboardingViewController() {

    }

    func makeOnboardingViewModel() {

    }

    // MARK: - Login
    func makeLoginViewController() {

    }

    func makeLoginViewModel() {

    }

    // MARK: - Terms Permission
    func makeTermsPermissionViewController() {

    }

    func makeTermsPermissionViewModel() {

    }

    // MARK: - Terms Detail
    func makeTermsDetailViewController() {

    }

    func makeTermsDetailViewModel() {

    }

    // MARK: - Nickname
    func makeNicknameViewController() {

    }

    func makeNicknameViewModel() {

    }

    // MARK: - Location Permission
    func makeLocationPermissionViewController() {

    }
}
