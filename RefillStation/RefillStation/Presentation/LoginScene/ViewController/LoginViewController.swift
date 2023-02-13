//
//  LoginViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/23.
//

import UIKit
import SnapKit
import AuthenticationServices

final class LoginViewController: UIViewController, ServerAlertable {
    private let viewModel: LoginViewModel
    var coordinator: OnboardingCoordinator?

    private let authorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        return ASAuthorizationController(authorizationRequests: [request])
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지구를 위한 리필 습관"
        label.font = .font(style: .bodyLarge)
        label.textColor = Asset.Colors.primary10.color
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconPump.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Asset.Colors.primary10.color
        return imageView
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.loginbackground.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()

    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오로 계속하기", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.setImage(Asset.Images.iconKakao.image, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.backgroundColor = Asset.Colors.kakao.color
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        return button
    }()

    private let naverLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("네이버로 계속하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(Asset.Images.iconNaver.image, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.backgroundColor = Asset.Colors.naver.color
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        return button
    }()

    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple로 계속하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(Asset.Images.iconApple.image, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.backgroundColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        return button
    }()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        bind()
        addLoginButtonActions()
        setUpAppleAuthorization()
    }

    private func layout() {
        view.addSubview(backgroundImageView)
        [backgroundImageView, titleLabel, iconImageView, loginButtonStackView].forEach { view.addSubview($0) }
        [kakaoLoginButton, appleLoginButton].forEach { loginButtonStackView.addArrangedSubview($0)
        }
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(72)
        }
        iconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        loginButtonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(104)
        }
    }

    private func bind() {
        viewModel.isSignUp = {
            if let requestValue = self.viewModel.signUpRequestValue {
                DispatchQueue.main.async {
                    self.coordinator?.showTermsPermission(requestValue: requestValue)
                }
            }
        }
        viewModel.isSignIn = {
            DispatchQueue.main.async {
                self.coordinator?.agreeAndStartButtonTapped()
            }
        }
        viewModel.showErrorAlert = showServerErrorAlert
    }

    private func setUpAppleAuthorization() {
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
    }

    private func addLoginButtonActions() {
        kakaoLoginButton.addAction(UIAction { _ in
            self.viewModel.onKakaoLoginByAppTouched()
        }, for: .touchUpInside)

        naverLoginButton.addAction(UIAction { _ in
            self.viewModel.onNaverLoginByAppTouched()
        }, for: .touchUpInside)

        appleLoginButton.addAction(UIAction { _ in
            self.authorizationController.performRequests()
        }, for: .touchUpInside)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            viewModel.onAppleLoginByAppTouched(appleIDCredential: appleIDCredential)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: 연동 실패시 처리
    }
}
