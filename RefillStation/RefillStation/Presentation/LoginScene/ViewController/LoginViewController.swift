//
//  LoginViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/23.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = Asset.Images.loginbackground.image
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
//        button.setImage(Asset.Images.iconApple.image, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.backgroundColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    private func layout() {
        view.addSubview(backgroundImageView)
        [backgroundImageView, loginButtonStackView].forEach { view.addSubview($0) }
        [kakaoLoginButton, naverLoginButton, appleLoginButton].forEach { loginButtonStackView.addArrangedSubview($0)
        }
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        loginButtonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(160)
        }
    }
}
