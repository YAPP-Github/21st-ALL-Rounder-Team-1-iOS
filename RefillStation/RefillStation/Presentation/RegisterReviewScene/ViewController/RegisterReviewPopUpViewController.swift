//
//  RegisterReviewPopUpViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/01.
//

import UIKit
import SnapKit

final class RegisterReviewPopUpViewController: UIViewController {

    var coordinator: RegisterReviewCoordinator?
    private let userLevel: UserLevelInfo.Level

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "리필 생활의 시작을 축하드려요!", font: .titleMedium)
        label.textColor = Asset.Colors.gray7.color
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "‘리필 유망주’까지\n리뷰 2회가 남았어요", font: .bodyMediumOverTwoLine)
        label.textColor = Asset.Colors.gray6.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var confirmButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("확인", for: .normal)
        button.addAction(UIAction { _ in
            self.dismiss(animated: true) {
                self.coordinator?.popUpDismissed()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히 알아보기", for: .normal)
        button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonMedium)
        button.addAction(UIAction { _ in
            self.dismiss(animated: true) {
                self.coordinator?.learnMoreButtonTapped(userLevel: self.userLevel)
            }
        }, for: .touchUpInside)
        return button
    }()

    init(userLevel: UserLevelInfo.Level) {
        self.userLevel = userLevel
        super.init(nibName: nil, bundle: nil)
        levelImageView.image = userLevel.image
        titleLabel.setText(text: userLevel.celebrateTitle, font: .titleMedium)
        setUpPopUpText()
        setUpReviewCountTextColor(count: userLevel.nextLevelRemainCount)
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        layout()
    }

    private func layout() {
        view.addSubview(containerView)
        [levelImageView, titleLabel, descriptionLabel,
         confirmButton, learnMoreButton].forEach { containerView.addSubview($0) }

        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
        levelImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(90)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(levelImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        learnMoreButton.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(67)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    private func setUpPopUpText() {
        switch userLevel {
        case .regular, .beginner, .prospect:
            descriptionLabel.setText(text: "‘\(userLevel.nextLevel.name)’까지\n리뷰 \(userLevel.nextLevelRemainCount)회가 남았어요",
                                     font: .bodyMediumOverTwoLine)
        case .fancier:
            descriptionLabel.setText(text: "앞으로도 꾸준한 리필 생활 부탁드려요!",
                                     font: .bodyMediumOverTwoLine)
        }
        [titleLabel, descriptionLabel].forEach { $0.textAlignment = .center }
    }

    private func setUpReviewCountTextColor(count: Int) {
        guard let text = self.descriptionLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: Asset.Colors.primary10.color,
                                     range: (text as NSString).range(of: "\(count)"))
        descriptionLabel.attributedText = attributeString
    }
}

fileprivate extension UserLevelInfo.Level {
    var celebrateTitle: String {
        switch self {
        case .beginner:
            return "리필생활의 시작을 축하드려요!"
        default:
            return "\(name)가 되셨네요!"
        }
    }
}
