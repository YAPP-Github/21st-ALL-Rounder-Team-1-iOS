//
//  NicknameViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/17.
//

import UIKit
import SnapKit
import PhotosUI

final class NicknameViewController: UIViewController {

    // MARK: - View Type Case
    enum ViewType {
        case onboarding
        case myPage
    }

    // MARK: - Properties
    private var viewType: ViewType
    private var viewModel: NicknameViewModel
    private var workItem: DispatchWorkItem?

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
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 36
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
    private let phPickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let phPickerVC = PHPickerViewController(configuration: configuration)
        return phPickerVC
    }()
    private let editProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    private lazy var editProfileBottomSheetView: EditProfileBottomSheetView = {
        let bottomSheetView = EditProfileBottomSheetView()
        bottomSheetView.albumButtonTapped = { [weak self] in
            self?.moveToPhotoPicker()
        }
        bottomSheetView.deleteButtonTapped = { [weak self] in
            self?.viewModel.profileImage = nil
            self?.editProfileView.isHidden = true
            self?.setUpProfileImage()
        }
        return bottomSheetView
    }()

    // MARK: - Common Components
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Asset.Colors.gray2.color.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        textField.tintColor = Asset.Colors.primary10.color
        textField.addTarget(self, action: #selector(setUpTextFieldState(_:)), for: .editingChanged)
        return textField
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .captionLarge)
        return label
    }()
    private lazy var doubleCheckButton: CTAButton = {
        let button = CTAButton(style: .doubleCheck)
        button.isEnabled = false
        button.setTitle("중복확인", for: .normal)
        button.addTarget(self, action: #selector(didTapDoubleCheckButton), for: .touchUpInside)
        return button
    }()
    private let confirmButton: CTAButton = {
        let button = CTAButton(style: .basic)
        return button
    }()

    // MARK: - initializer
    init(viewModel: NicknameViewModel, viewType: ViewType) {
        self.viewModel = viewModel
        self.viewType = viewType
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
        phPickerViewController.delegate = self
        addTapGesture()
        addKeyboardNotification()
        layout()
        setUpView()
    }

    // MARK: - Methods
    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setUpView() {
        switch viewType {
        case .onboarding:
            nicknameTextField.text = viewModel.randomNickname
            confirmButton.setTitle("다음", for: .normal)
        case .myPage:
            title = "프로필 수정"
            nicknameTextField.text = viewModel.userNickname
            confirmButton.setTitle("완료", for: .normal)
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
        [nicknameTextField, descriptionLabel, doubleCheckButton, confirmButton].forEach { view.addSubview($0) }
        var topView: UIView
        switch viewType {
        case .onboarding:
            topView = subGuideLabel
            onboardingLayout()
        case .myPage:
            topView = profileImageView
            myPageLayout()
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(nicknameTextField)
        }
        doubleCheckButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField)
            $0.leading.equalTo(nicknameTextField.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(83)
            $0.height.equalTo(44)
        }
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-6)
            $0.height.equalTo(50)
        }
    }

    private func onboardingLayout() {
        [guideLabel, subGuideLabel].forEach { view.addSubview($0) }
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        subGuideLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(guideLabel)
        }
    }

    private func myPageLayout() {
        [profileImageView, profileImageEditButton, editProfileView].forEach { view.addSubview($0) }
        editProfileView.addSubview(editProfileBottomSheetView)
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.width.height.equalTo(72)
            $0.centerX.equalToSuperview()
        }
        profileImageEditButton.snp.makeConstraints {
            $0.trailing.equalTo(profileImageView).offset(8)
            $0.bottom.equalTo(profileImageView).offset(8)
            $0.width.height.equalTo(32)
        }
        editProfileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        editProfileBottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(164)
        }
    }

    private func setEmptyNickname() {
        nicknameTextField.layer.borderColor = Asset.Colors.gray4.color.cgColor
        descriptionLabel.textColor = Asset.Colors.gray3.color
        doubleCheckButton.isEnabled = false
    }

    private func setIncorrectNickname() {
        nicknameTextField.layer.borderColor = Asset.Colors.error.color.cgColor
        descriptionLabel.textColor = Asset.Colors.error.color
        doubleCheckButton.isEnabled = false
    }

    private func setCorrectNickname() {
        nicknameTextField.layer.borderColor = Asset.Colors.gray4.color.cgColor
        doubleCheckButton.isEnabled = true
    }

    private func setNicknameState(isValid: Bool) {
        if isValid {
            descriptionLabel.text = "사용 가능한 닉네임입니다"
            nicknameTextField.layer.borderColor = Asset.Colors.correct.color.cgColor
            descriptionLabel.textColor = Asset.Colors.correct.color
            doubleCheckButton.isEnabled = true
        } else {
            descriptionLabel.text = "다른 사용자가 이미 사용중 입니다"
            setIncorrectNickname()
        }
    }

    private func moveToPhotoPicker() {
        self.present(phPickerViewController, animated: true)
    }

    private func addTapGesture() {
        editProfileView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                          action: #selector(hideEditProfileView)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard)))
    }
}

// MARK: - Action Methods
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
        if text.isEmpty {
            descriptionLabel.text = "닉네임을 입력해주세요"
            setEmptyNickname()
        } else {
            if text.count < 2 {
                descriptionLabel.text = "닉네임은 2자 이상 입력해주세요"
                setIncorrectNickname()
            } else if text.count > 10 {
                descriptionLabel.text = "닉네임은 10자 이하로 입력해주세요"
                setIncorrectNickname()
            } else {
                descriptionLabel.text = ""
                setCorrectNickname()
            }
        }
    }

    @objc private func didTapDoubleCheckButton() {
        if self.workItem == nil {
            if viewModel.userNickname != nicknameTextField.text {
                setNicknameState(isValid: viewModel.isVaild)
            }
            let workItem = DispatchWorkItem(block: { [weak self] in
                self?.workItem?.cancel()
                self?.workItem = nil
            })
            self.workItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: workItem)
        }
    }

    @objc private func didTapProfileImageEditButton() {
        editProfileView.isHidden = false
    }

    @objc private func hideEditProfileView() {
        editProfileView.isHidden = true
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NicknameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasVaildCharacters() || isBackSpace == -92 { return true }
        return false
    }
}

extension NicknameViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        editProfileView.isHidden = true
        let item = results.first?.itemProvider
        if let item = item, item.canLoadObject(ofClass: UIImage.self) {
            item.loadObject(ofClass: UIImage.self) { (image, _) in
                DispatchQueue.main.async {
                    self.profileImageView.image = image as? UIImage
                }
            }
        }
    }
}

fileprivate extension String {
    func hasVaildCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]$",
                                                options: .caseInsensitive)
            if regex.firstMatch(in: self,
                                options: NSRegularExpression.MatchingOptions.reportCompletion,
                                range: NSRange(location: 0, length: self.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}
