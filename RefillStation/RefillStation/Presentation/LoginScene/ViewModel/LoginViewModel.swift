//
//  LoginViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/02/05.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth

final class LoginViewModel {
    private let OAuthLoginUseCase: OAuthLoginUseCaseInterface
    private var loginTask: Cancellable?

    var signUpRequestValue: SignUpRequestValue?
    var isSignUp: (() -> Void)?
    var isSignIn: (() -> Void)?

    init(OAuthLoginUseCase: OAuthLoginUseCaseInterface) {
        self.OAuthLoginUseCase = OAuthLoginUseCase
    }

    private func requestKakaoLogin(requestValue: String) {
        loginTask = OAuthLoginUseCase.execute(
            loginType: .kakao, requestValue: OAuthLoginRequestValue(accessToken: requestValue)
        ) { result in
            switch result {
            case .success(let data):
                self.signUpRequestValue = SignUpRequestValue(
                    name: data.name,
                    email: data.email,
                    imagePath: data.imgPath,
                    oauthType: data.oauthType,
                    oauthIdentity: data.oauthIdentity
                )
                data.jwt == nil ? self.isSignUp?() : self.isSignIn?()
            case .failure(let failure):
                return
            }
        }
        loginTask?.resume()
    }

    private func requestNaverLogin(requestValue: String) {

    }

    private func requestAppleLogin(requestValue: String) {

    }
}

extension LoginViewModel {

    // MARK: - ViewController의 LoginButton이 눌릴 때 호출되는 메소드
    func loginButtonDidTapped(OAuthType: OAuthType, requestValue: String) {
        switch OAuthType {
        case .apple:
            requestAppleLogin(requestValue: requestValue)
        case .kakao:
            requestKakaoLogin(requestValue: requestValue)
        case .naver:
            requestAppleLogin(requestValue: requestValue)
        }
    }

    func onKakaoLoginByAppTouched() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let accessToken = oauthToken?.accessToken else { return }
                    self.loginButtonDidTapped(OAuthType: .kakao,
                                              requestValue: accessToken)
                }
            }
        }
    }

    func onNaverLoginByAppTouched() {

    }

    func onAppleLoginByAppTouched() {

    }
}
