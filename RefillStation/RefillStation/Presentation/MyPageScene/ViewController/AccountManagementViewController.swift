//
//  AccountManagementViewController.swift
//  RefillStation
//
//  Created by kong on 2023/02/08.
//

import UIKit
import SnapKit

final class AccountManagementViewController: UIViewController, ServerAlertable {
    var coordinator: MyPageCoordinator?
    private let viewModel: AccountManagementViewModel

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Asset.Colors.gray1.color
        stackView.spacing = 1
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.addSignOutAction()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.addWithdrawAction()
        }), for: .touchUpInside)
        return button
    }()

    init(viewModel: AccountManagementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        layout()
        setUpButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        tabBarController?.tabBar.isHidden = false
    }

    private func setUpNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = Asset.Colors.gray7.color
        title = "계정 관리"
    }

    private func bind() {
        viewModel.presentToLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.coordinator?.showOnboardingLogin()
            }
        }
        viewModel.showErrorAlert = { [weak self] (title, message) in
            self?.showServerErrorAlert(title: title, message: message)
        }
    }

    private func layout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }

        [signOutButton, withdrawButton].forEach { button in
            stackView.addArrangedSubview(button)
            button.snp.makeConstraints {
                $0.height.equalTo(56)
            }
        }
    }

    private func setUpButton() {
        [signOutButton, withdrawButton].forEach { button in
            button.backgroundColor = .white
            button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
            button.titleLabel?.font = .font(style: .buttonLarge)
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            let arrowImageView = UIImageView(
                image: Asset.Images.iconArrowRightSmall.image.withRenderingMode(.alwaysTemplate)
            )
            arrowImageView.tintColor = Asset.Colors.gray3.color

            button.addSubview(arrowImageView)
            arrowImageView.snp.makeConstraints { imageView in
                imageView.centerY.equalToSuperview()
                imageView.trailing.equalToSuperview().inset(16)
            }
        }
    }

    private func addSignOutAction() {
        let popUp = PumpPopUpViewController(title: "로그아웃하시겠습니까?", description: nil)
        popUp.addAction(title: "취소", style: .cancel) {
            self.dismiss(animated: true)
        }
        popUp.addAction(title: "로그아웃", style: .basic) {
            self.dismiss(animated: true) { [weak self] in
                self?.viewModel.signOutButtonDidTapped()
            }
        }
        self.present(popUp, animated: false)
    }

    private func addWithdrawAction() {
        let popUp = PumpPopUpViewController(title: "탈퇴하시겠습니까?",
                                            description: "탈퇴 후 삭제된 정보는 복구가 불가합니다")
        popUp.addAction(title: "취소", style: .cancel) {
            self.dismiss(animated: true)
        }
        popUp.addAction(title: "탈퇴하기", style: .basic) {
            self.dismiss(animated: true) { [weak self] in
                self?.viewModel.withdrawButtonDidTapped()
            }
        }
        self.present(popUp, animated: false)
    }
}
