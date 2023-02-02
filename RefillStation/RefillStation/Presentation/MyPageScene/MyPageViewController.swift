//
//  MyPageViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class MyPageViewController: UIViewController {

    private let viewModel: MyPageViewModel
    var coordinator: MyPageCoordinator?

    private let largeTitleBar: PumpLargeTitleNavigationBar = {
        let bar = PumpLargeTitleNavigationBar()
        bar.setNavigationTitle("마이페이지")
        return bar
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.avatar.image
        return imageView
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleMedium)
        return label
    }()

    private let userLevelTagView: PumpTagView = {
        let tagView = PumpTagView()
        return tagView
    }()

    private lazy var userInfoView: UIView = {
        let userInfoView = UIView()
        [profileImageView, nicknameLabel, userLevelTagView].forEach { userInfoView.addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.top.bottom.equalToSuperview().inset(24)
            $0.height.width.equalTo(64)
        }
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(31.5)
        }
        userLevelTagView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(6)
        }
        return userInfoView
    }()

    private lazy var changeProfileCell = listCell(title: "프로필 수정")
    private lazy var magnageAccountCell = listCell(title: "계정 관리")
    private lazy var termsAndConditionsCell = listCell(title: "이용약관")
    private lazy var personalInfoPolicyCell = listCell(title: "개인정보 처리방침")
    private lazy var versionCell = listCell(title: "버전", version: "V 1.0.9")

    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = Asset.Colors.gray1.color
        stackView.spacing = 1
        return stackView
    }()

    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        layout()
        addAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        viewModel.viewWillApeear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func bind() {
        viewModel.applyDataSource = {
            self.nicknameLabel.text = self.viewModel.userNickname
            self.userLevelTagView.setUpTagLevel(level: self.viewModel.userRank ?? .beginner)
            self.profileImageView.image = nil
        }
    }

    private func layout() {
        [largeTitleBar, userInfoView, listStackView].forEach { view.addSubview($0) }
        largeTitleBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58)
        }
        userInfoView.snp.makeConstraints {
            $0.top.equalTo(largeTitleBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        listStackView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        listStackView.addArrangedSubview(divisionLine(height: 8))
        [changeProfileCell, magnageAccountCell].forEach {
            listStackView.addArrangedSubview($0)
        }
        listStackView.addArrangedSubview(divisionLine(height: 8))
        [termsAndConditionsCell, personalInfoPolicyCell, versionCell].forEach {
            listStackView.addArrangedSubview($0)
        }
        listStackView.addArrangedSubview(divisionLine(height: 0))
    }

    private func listCell(title: String, version: String? = nil) -> UIView {
        let outerView = UIView()
        outerView.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .font(style: .buttonLarge)
        titleLabel.textColor = Asset.Colors.gray6.color

        let versionLabel = UILabel()
        versionLabel.text = version
        versionLabel.font = .font(style: .captionLarge)
        versionLabel.textColor = Asset.Colors.gray4.color

        let disclosureImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        disclosureImageView.tintColor = Asset.Colors.gray3.color
        disclosureImageView.contentMode = .scaleAspectFit
        disclosureImageView.isHidden = version != nil

        [titleLabel, versionLabel, disclosureImageView].forEach { outerView.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(19)
        }

        versionLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(19)
        }

        disclosureImageView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(16)
        }

        return outerView
    }

    private func divisionLine(height: CGFloat) -> UIView {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        line.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return line
    }

    private func addAction() {
        changeProfileCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(presentToChangeProfile)))
        personalInfoPolicyCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                           action: #selector(presentToPrivacyPolicy)))
        termsAndConditionsCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                           action: #selector(presentToServiceTerms)))
    }

    @objc private func presentToChangeProfile() {
        coordinator?.showEditProfile()
    }

    @objc private func presentToServiceTerms() {
        coordinator?.showTermsDetails(termsType: .serviceTerms)
    }

    @objc private func presentToPrivacyPolicy() {
        coordinator?.showTermsDetails(termsType: .privacyPolicy)
    }
}
