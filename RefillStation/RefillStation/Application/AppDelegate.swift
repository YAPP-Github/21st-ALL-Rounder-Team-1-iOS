//
//  AppDelegate.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var onboardingDIContainer: OnboardingDIContainer?
    var onboardingCoordinator: OnboardingCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.setUpNavigationBar()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let rootViewController = UIViewController()
        window?.rootViewController = rootViewController
        onboardingDIContainer = OnboardingDIContainer(navigationController: navigationController,
                                                      viewController: rootViewController)
        onboardingCoordinator = onboardingDIContainer?.makeOnboardingCoordinator()
        if didLoginSuccessed() {
            onboardingCoordinator?.agreeAndStartButtonTapped()
        } else {
            onboardingCoordinator?.start()
        }
        window?.makeKeyAndVisible()
        return true
    }

    static func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func didLoginSuccessed() -> Bool {
        return true
    }
}
