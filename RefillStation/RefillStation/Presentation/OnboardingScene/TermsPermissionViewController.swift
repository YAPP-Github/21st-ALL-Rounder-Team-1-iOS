//
//  TermsPermissionViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/29.
//

import UIKit
import SnapKit

final class TermsPermissionViewController: UIViewController {
    private let viewModel: TermsPermissionViewModel
    var coordinator: OnboardingCoordinator?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "이용 약관 동의", font: .titleLarge2)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private lazy var entireAgreeButton: UIButton = {
        let button = UIButton()
        button.isSelected = false
        button.setTitle("모두 동의합니다.", for: .normal)
        button.titleLabel?.font = .font(style: .titleMedium)
        button.contentHorizontalAlignment = .left
        button.layer.borderColor = Asset.Colors.gray2.color.cgColor
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.setImage(Asset.Images.unselectedBox.image, for: .normal)
        button.setImage(Asset.Images.selectedBox.image, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addAction(UIAction(handler: { _ in
            self.entireAgreeButtonDidTapped()
        }), for: .touchUpInside)
        return button
    }()
    private let divisionLine: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var confirmButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("동의합니다", for: .normal)
        button.titleLabel?.font = .font(style: .titleMedium)
        button.isEnabled = false
        button.addAction(UIAction { _ in
            self.coordinator?.showLocationAuthorization(requestValue: self.viewModel.requestValue)
        }, for: .touchUpInside)
        return button
    }()

    init(viewModel: TermsPermissionViewModel) {
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
        setUpStackViewButtons()
        setUpButtonState()
    }

    private func layout() {
        [titleLabel, entireAgreeButton, divisionLine,
         stackView, confirmButton].forEach { view.addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        entireAgreeButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        divisionLine.snp.makeConstraints {
            $0.top.equalTo(entireAgreeButton.snp.bottom)
            $0.leading.trailing.equalTo(entireAgreeButton)
            $0.height.equalTo(1)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(divisionLine.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(96)
        }
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(6)
        }
    }

    private func setUpStackViewButtons() {
        TermsType.allCases.forEach { agreementType in
            let button = UIButton()
            button.isSelected = false
            button.setImage(Asset.Images.checkbox.image.withRenderingMode(.alwaysTemplate),
                            for: .normal)
            button.setImage(Asset.Images.checkbox.image.withTintColor(Asset.Colors.primary10.color),
                            for: .selected)
            button.tintColor = Asset.Colors.gray3.color
            button.contentHorizontalAlignment = .left
            button.setTitle(agreementType.title + " (필수)", for: .normal)
            button.titleLabel?.font = .font(style: .bodyMedium)
            button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
            setUpButtonTitleTextColor(button: button)

            let arrowButton = UIButton()
            arrowButton.setImage(Asset.Images.iconArrowRightSmall.image.withRenderingMode(.alwaysTemplate),
                                 for: .normal)
            arrowButton.tintColor = Asset.Colors.gray3.color
            arrowButton.addAction(UIAction(handler: { _ in
                self.coordinator?.showTermsPermissionDetail(termsType: agreementType)
            }), for: .touchUpInside)

            stackView.addArrangedSubview(button)
            button.addSubview(arrowButton)
            arrowButton.snp.makeConstraints {
                $0.top.bottom.trailing.equalToSuperview()
                $0.width.equalTo(arrowButton)
            }
        }
    }

    private func entireAgreeButtonDidTapped() {
        entireAgreeButton.isSelected.toggle()
        confirmButton.isEnabled = entireAgreeButton.isSelected
        guard let buttons = stackView.arrangedSubviews as? [UIButton] else { return }
        buttons.forEach { button in
            button.isSelected = entireAgreeButton.isSelected
        }
    }

    private func setUpButtonState() {
        guard let buttons = stackView.arrangedSubviews as? [UIButton] else { return }
        buttons.forEach { button in
            button.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                button.isSelected.toggle()
                let state = self.viewModel.didAgreeAllAgreements(buttons: buttons)
                self.confirmButton.isEnabled = state
                self.entireAgreeButton.isSelected = state
            }), for: .touchUpInside)
        }
    }

    private func setUpButtonTitleTextColor(button: UIButton) {
        guard let text = button.titleLabel?.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: Asset.Colors.primary10.color,
                                     range: (text as NSString).range(of: "(필수)"))
        button.setAttributedTitle(attributeString, for: .normal)
    }
}
