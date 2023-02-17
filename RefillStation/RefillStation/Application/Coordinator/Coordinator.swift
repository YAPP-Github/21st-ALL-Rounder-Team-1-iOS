//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

protocol Coordinator: AnyObject {
    associatedtype DIContainerProtocol: DIContainer
    var DIContainer: DIContainerProtocol { get }

    func start()
}

extension Coordinator {
    func showLookAroundLogin() {
        let onboardingDIContainer = OnboardingDIContainer()
        let onboardingCoordinator = onboardingDIContainer.makeOnboardingCoordinator()
        UserDefaults.standard.setValue(true, forKey: "didLookAroundLoginStarted")
        onboardingCoordinator.showLogin(viewType: .lookAround)
    }
}
