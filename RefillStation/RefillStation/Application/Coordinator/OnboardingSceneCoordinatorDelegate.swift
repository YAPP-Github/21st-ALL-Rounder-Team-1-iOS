//
//  OnboardingSceneCoordinatorDelegate.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

final class OnboardingSceneCoordinator: Coordinator, OnboardingViewModelCoordinatorDelegate {
    var DIContainer: OnboardingDIContainer
    // onboardingViewController

    init(DIContainer: OnboardingDIContainer) {
        self.DIContainer = DIContainer
    }

    func start() {

    }

    func showOnboarding() {

    }

    func showLocationAuthorization() {

    }

    func agreeAndStartButtonTapped() {

    }
}
