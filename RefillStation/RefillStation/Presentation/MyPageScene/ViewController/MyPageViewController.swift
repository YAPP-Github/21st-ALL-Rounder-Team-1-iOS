//
//  MyPageViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit
import Kingfisher

final class MyPageViewController: UIViewController, ServerAlertable {

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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleSmallOverTwoLine)
        label.numberOfLines = 2
        return label
    }()

    private lazy var userLevelTagView: PumpTagView = {
        let tagView = PumpTagView()
        tagView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                            action: #selector(presentToLevelInfo)))
        return tagView
    }()

    private lazy var userInfoView: UIView = {
        let userInfoView = UIView()
        let outerView = UIView()
        [nicknameLabel, userLevelTagView].forEach { outerView.addSubview($0) }
        [profileImageView, outerView].forEach { userInfoView.addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.top.bottom.equalToSuperview().inset(24)
            $0.height.width.equalTo(64)
        }
        outerView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        nicknameLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)        }
        userLevelTagView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(6)
            $0.leading.bottom.equalToSuperview()
        }
        return userInfoView
    }()

    private lazy var lookAroundUserMaskView: UIView = {
        let maskView = UIView()
        maskView.backgroundColor = .white
        let maskButton = UIButton()
        maskButton.setTitle("로그인 & 가입하기", for: .normal)
        maskButton.semanticContentAttribute = .forceRightToLeft
        maskButton.backgroundColor = .white
        maskButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        maskButton.titleLabel?.font = .font(style: .titleMedium)
        maskButton.setImage(Asset.Images.iconArrowRightSmall.image.withRenderingMode(.alwaysTemplate), for: .normal)
        maskButton.tintColor = Asset.Colors.gray5.color
        maskView.addSubview(maskButton)
        maskButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        maskButton.addAction(UIAction { [weak self] _ in
            self?.coordinator?.showLogin(viewType: .lookAround)
        }, for: .touchUpInside)
        return maskView
    }()

    private lazy var changeProfileCell = listCell(title: "프로필 수정")
    private lazy var manageAccountCell = listCell(title: "계정 관리")
    private lazy var termsAndConditionsCell = listCell(title: TermsType.serviceTerms.title)
    private lazy var locationTermsCell = listCell(title: TermsType.location.title)
    private lazy var personalInfoPolicyCell = listCell(title: TermsType.privacyPolicy.title)
    private lazy var versionCell = listCell(title: "버전", version: viewModel.appVersion())

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
        lookAroundUserMaskView.isHidden = !UserDefaults.standard.bool(forKey: "isLookAroundUser")
        viewModel.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        viewModel.viewWillDisappear()
    }

    private func bind() {
        viewModel.setUpContents = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.nicknameLabel.text = self.viewModel.userNickname
                self.userLevelTagView.setUpTagLevel(level: self.viewModel.userRank ?? .beginner)
                self.setUpProfileView()
            }
        }
        viewModel.showErrorAlert = { [weak self] (title, message) in
            self?.showServerErrorAlert(title: title, message: message)
        }
    }

    private func setUpProfileView() {
        if viewModel.profileImage == nil {
            profileImageView.image = Asset.Images.avatar.image
        } else {
            profileImageView.kf.setImage(with: URL(string: viewModel.profileImage ?? ""))
        }
    }

    private func layout() {
        [largeTitleBar, userInfoView, listStackView, lookAroundUserMaskView].forEach { view.addSubview($0) }
        largeTitleBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58)
        }
        userInfoView.snp.makeConstraints {
            $0.top.equalTo(largeTitleBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        lookAroundUserMaskView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.bottom.trailing.equalTo(userInfoView)
        }

        listStackView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        listStackView.addArrangedSubview(divisionLine(height: 8))
        [changeProfileCell, manageAccountCell].forEach {
            listStackView.addArrangedSubview($0)
        }
        listStackView.addArrangedSubview(divisionLine(height: 8))
        [termsAndConditionsCell, locationTermsCell, personalInfoPolicyCell, versionCell].forEach {
            listStackView.addArrangedSubview($0)
        }
        listStackView.addArrangedSubview(divisionLine(height: 0))
    }

    private func listCell(title: String, version: String? = nil) -> UIView {
        let outerView = UIView()
        outerView.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.setText(text: title, font: .buttonLarge)
        titleLabel.textColor = Asset.Colors.gray6.color

        let versionLabel = UILabel()
        versionLabel.setText(text: version, font: .captionLarge)
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
        manageAccountCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(presentToManagementAccount)))
        personalInfoPolicyCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                           action: #selector(presentToPrivacyPolicy)))
        locationTermsCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(presentToLocationTerms)))
        termsAndConditionsCell.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                           action: #selector(presentToServiceTerms)))
    }

    @objc private func presentToLevelInfo() {
        coordinator?.showLevelInfo()
    }

    @objc private func presentToChangeProfile() {
        coordinator?.showEditProfile(user: User(id: viewModel.userId ?? 0,
                                                name: viewModel.userNickname ?? "",
                                                imageURL: viewModel.profileImage,
                                                level: viewModel.userLevel ?? .init(level: .beginner)))
    }

    @objc private func presentToManagementAccount() {
        coordinator?.showManagementAccount()
    }

    @objc private func presentToServiceTerms() {
        coordinator?.showTermsDetails(termsType: .serviceTerms)
    }

    @objc private func presentToLocationTerms() {
        coordinator?.showTermsDetails(termsType: .location)
    }

    @objc private func presentToPrivacyPolicy() {
        coordinator?.showTermsDetails(termsType: .privacyPolicy)
    }
}
