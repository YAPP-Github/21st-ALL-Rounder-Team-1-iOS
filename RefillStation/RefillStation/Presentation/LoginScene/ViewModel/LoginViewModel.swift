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
    var isSignUp: (() -> Void)?
    var isSignIn: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

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
                self.signUpRequestValue = SignUpRequestValue(
                    name: result.name,
                    email: result.email,
                    imagePath: result.imgPath,
                    oauthType: result.oauthType,
                    oauthIdentity: result.oauthIdentity
                )
                result.jwt == nil ? self.isSignUp?() : self.isSignIn?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
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
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
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
        self.requestLogin(oauthType: .apple, requestValue: token)
    }

    func onNaverLoginByAppTouched() {

    }
}
