//
//  LoginViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/02/05.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices

final class LoginViewModel {
    private let OAuthLoginUseCase: OAuthLoginUseCaseInterface

    var signUpRequestValue: SignUpRequestValue?
    private var appleUserName: String?
    private var appleUserEmail: String?
    var isSignUp: (() -> Void)?
    var isSignIn: (() -> Void)?

    init(OAuthLoginUseCase: OAuthLoginUseCaseInterface) {
        self.OAuthLoginUseCase = OAuthLoginUseCase
    }

    private func requestLogin(oauthType: OAuthType, requestValue: String) {
        Task {
            do {
                let result = try await OAuthLoginUseCase.execute(
                    loginType: oauthType,
                    requestValue: OAuthLoginRequestValue(accessToken: requestValue)
                )
                let name = oauthType == .apple ? appleUserName : result.name
                let email = oauthType == .apple ? appleUserEmail : result.email
                self.signUpRequestValue = SignUpRequestValue(
                    name: name,
                    email: email,
                    imagePath: result.imgPath,
                    oauthType: result.oauthType,
                    oauthIdentity: result.oauthIdentity
                )
                result.jwt == nil ? self.isSignUp?() : self.isSignIn?()
            } catch {
                print(error)
            }
        }
    }
}

extension LoginViewModel {

    // MARK: - ViewController의 LoginButton이 눌릴 때 호출되는 메소드

    func onKakaoLoginByAppTouched() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let accessToken = oauthToken?.accessToken else { return }
                    self.requestLogin(oauthType: .kakao, requestValue: accessToken)
                }
            }
        }
    }

    func onAppleLoginByAppTouched(appleIDCredential: ASAuthorizationAppleIDCredential) {
        guard let identityToken = appleIDCredential.identityToken,
              let token = String(data: identityToken, encoding: .utf8) else { return }
        appleUserEmail = appleIDCredential.email
        if let familyName = appleIDCredential.fullName?.familyName,
           let givenName = appleIDCredential.fullName?.givenName {
            appleUserName = familyName + givenName
        }
        self.requestLogin(oauthType: .apple, requestValue: token)
    }

    func onNaverLoginByAppTouched() {

    }
}
