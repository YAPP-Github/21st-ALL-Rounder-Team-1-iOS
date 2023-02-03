//
//  NicknameViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/17.
//

import UIKit
import SnapKit

final class NicknameViewController: UIViewController {
    private let viewModel: NicknameViewModel
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Onboarding Components

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "이 닉네임 어떠신가요?\n원하는 닉네임으로 바꿔도 괜찮아요!"
        label.numberOfLines = 0
        label.font = .font(style: .titleLarge2)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let subGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임은 추후 마이페이지에서 수정할 수 있어요"
        label.font = .font(style: .bodySmall)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    // MARK: - My page Components

    private let profileView: UIView = {
        let view = UIView()
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 36
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var profileImageEditButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(Asset.Images.iconPhoto.image.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.tintColor = Asset.Colors.gray4.color
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = Asset.Colors.gray2.color.cgColor
        button.addTarget(self, action: #selector(didTapProfileImageEditButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Common Components

    private let nicknameView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Asset.Colors.gray2.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.tintColor = Asset.Colors.primary10.color
        textField.delegate = self
        textField.addTarget(self, action: #selector(setUpTextFieldState(_:)), for: .editingChanged)
        return textField
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .captionLarge)
        return label
    }()
    private lazy var doubleCheckButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("중복확인", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(Asset.Colors.gray4.color, for: .disabled)
        button.backgroundColor = Asset.Colors.gray2.color
        button.addTarget(self, action: #selector(didTapDoubleCheckButton), for: .touchUpInside)
        return button
    }()
    private let confirmButton: CTAButton = {
        let button = CTAButton(style: .basic)
        return button
    }()

    // MARK: - initializer
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nicknameTextField.delegate = self
        addTapGesture()
        addKeyboardNotification()
        layout()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Methods

    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = Asset.Colors.gray7.color
    }

    private func setUpView() {
        switch viewModel.viewType {
        case .onboarding:
            nicknameTextField.text = viewModel.randomNickname
            confirmButton.setTitle("다음", for: .normal)
            confirmButton.isEnabled = true
        case .myPage:
            title = "프로필 수정"
            nicknameTextField.text = viewModel.userNickname
            confirmButton.setTitle("완료", for: .normal)
            confirmButton.isEnabled = false
            setUpProfileImage()
        }
    }

    private func setUpProfileImage() {
        if viewModel.profileImage != nil {
            // 이미지 세팅
        } else {
            profileImageView.image = Asset.Images.avatar.image
        }
    }

    private func layout() {
        [stackView, confirmButton].forEach { view.addSubview($0) }
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-6)
            $0.height.equalTo(50)
        }

        [profileImageView, profileImageEditButton].forEach { profileView.addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(72)
            $0.centerX.equalToSuperview()
        }
        profileImageEditButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(profileImageView).offset(8)
            $0.width.height.equalTo(32)
            $0.bottom.equalToSuperview()
        }

        [nicknameTextField, doubleCheckButton, descriptionLabel].forEach { nicknameView.addSubview($0) }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.height.equalTo(44)
            $0.leading.equalToSuperview()
        }
        doubleCheckButton.snp.makeConstraints {
            $0.top.bottom.equalTo(nicknameTextField)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(nicknameTextField.snp.trailing).offset(8)
            $0.width.equalTo(83)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(6)
            $0.leading.equalTo(nicknameTextField)
            $0.bottom.equalToSuperview()
        }

        switch viewModel.viewType {
        case .myPage:
            [profileView, nicknameView].forEach { stackView.addArrangedSubview($0)}
        case .onboarding:
            [guideLabel, subGuideLabel, nicknameView].forEach { stackView.addArrangedSubview($0) }
        }
    }

    private func setNicknameButton(state: NicknameViewModel.NicknameState) {
        descriptionLabel.text = state.description
        nicknameTextField.layer.borderColor = state.borderColor
        descriptionLabel.textColor = state.textColor
        switch state {
        case .empty, .overTenCharacters, .underTwoCharacters:
            setDoubleCheckButtonState(isEnabled: false)
        case .correct:
            setDoubleCheckButtonState(isEnabled: viewModel.userNickname != nicknameTextField.text)
        }
    }

    private func setDoubleCheckButtonState(isEnabled: Bool) {
        doubleCheckButton.isEnabled = isEnabled
        doubleCheckButton.backgroundColor = isEnabled ? Asset.Colors.gray5.color : Asset.Colors.gray2.color
    }

    private func setUpConfirmButtonState() {
        confirmButton.isEnabled = viewModel.isVaild
    }

    private func doubleCheckNickname(isValid: Bool) {
        if isValid {
            descriptionLabel.text = "사용 가능한 닉네임입니다"
            nicknameTextField.layer.borderColor = Asset.Colors.correct.color.cgColor
            descriptionLabel.textColor = Asset.Colors.correct.color
        } else {
            descriptionLabel.text = "다른 사용자가 이미 사용중 입니다"
            nicknameTextField.layer.borderColor = Asset.Colors.error.color.cgColor
            descriptionLabel.textColor = Asset.Colors.error.color
        }
        setDoubleCheckButtonState(isEnabled: false)
        confirmButton.isEnabled = isValid
    }

    private func addTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard)))
    }
}

extension NicknameViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.confirmButton.transform = CGAffineTransform(translationX: 0, y: -keyboardRect.height)
        })
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.confirmButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }

    @objc private func setUpTextFieldState(_ sender: UITextField) {
        guard let text = sender.text else { return }
        confirmButton.isEnabled = false
        let nicknameState = viewModel.setNicknameState(count: text.count)
        setNicknameButton(state: nicknameState)
    }

    @objc private func didTapDoubleCheckButton() {
        doubleCheckNickname(isValid: viewModel.isVaild)
    }

    @objc private func didTapProfileImageEditButton() {
        let viewContolller = EditProfileBottomSheetViewController()
        viewContolller.modalPresentationStyle = .overFullScreen
        viewContolller.modalTransitionStyle = .crossDissolve
        viewContolller.deleteProfileImage = { [weak self] in
            self?.viewModel.profileImage = nil
            self?.setUpProfileImage()
            self?.setUpConfirmButtonState()
        }
        viewContolller.didFinishPhotoPicker = { [weak self] image in
            self?.profileImageView.image = image
            self?.setUpConfirmButtonState()
        }
        self.present(viewContolller, animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NicknameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        viewModel.isValidCharacters(string: string)
    }
}
