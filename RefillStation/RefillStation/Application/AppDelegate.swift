//
//  AppDelegate.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import CoreData
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var onboardingDIContainer: OnboardingDIContainer?
    var onboardingCoordinator: OnboardingCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let kakaoNativeAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY")
                as? String else { return false }
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)

        AppDelegate.setUpNavigationBar()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let rootViewController = UIViewController()
        window?.rootViewController = rootViewController
        onboardingDIContainer = OnboardingDIContainer(navigationController: navigationController,
                                                      window: window)
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
        let backButtonImage: UIImage? = {
            return Asset.Images.iconArrowLeft.image.withAlignmentRectInsets(
                UIEdgeInsets(top: 0.0, left: -8.0, bottom: 0, right: 0.0)
            )
        }()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = Asset.Colors.gray2.color
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func didLoginSuccessed() -> Bool {
        return KeychainManager.shared.getItem(key: "token") != nil
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
     if AuthApi.isKakaoTalkLoginUrl(url) {
       return AuthController.handleOpenUrl(url: url)
     }
    return false
    }
}
