//
//  RegisterReviewPopUpViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/01.
//

import UIKit
import SnapKit

final class RegisterReviewPopUpViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "리필 생활의 시작을 축하드려요!"
        label.textColor = Asset.Colors.gray7.color
        label.font = .font(style: .titleMedium)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "‘리필 유망주’까지\n리뷰 2회가 남았어요"
        label.textColor = Asset.Colors.gray6.color
        label.font = .font(style: .bodyMedium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let confirmButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("확인", for: .normal)
        return button
    }()

    private let learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히 알아보기", for: .normal)
        button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonMedium)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        layout()
        setUpReviewCountTextColor(count: 2)
    }

    private func layout() {
        view.addSubview(containerView)
        [levelImageView, titleLabel, descriptionLabel, confirmButton, learnMoreButton].forEach { containerView.addSubview($0) }

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

    private func setUpReviewCountTextColor(count: Int) {
        guard let text = self.descriptionLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: Asset.Colors.primary10.color,
                                     range: (text as NSString).range(of: "\(count)"))
        descriptionLabel.attributedText = attributeString
    }
}
