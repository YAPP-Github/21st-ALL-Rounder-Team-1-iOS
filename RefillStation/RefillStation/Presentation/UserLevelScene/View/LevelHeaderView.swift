//
//  LevelHeaderView.swift
//  RefillStation
//
//  Created by kong on 2023/01/07.
//

import UIKit
import SnapKit

final class LevelHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "LevelHeaderView"
    private let levelView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()

    private let levelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleLarge2)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        label.textAlignment = .center
        return label
    }()

    private let remainingReviewTagView: PumpTagView = {
        let tagView = PumpTagView()
        return tagView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "회원 등급 자세히 보기", font: .titleSmall)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(level: UserLevelInfo.Level, totalReviewCount: Int) {
        levelLabel.setText(text: level.name, font: .titleLarge2)
        levelImage.image = level.image
        remainingReviewTagView.setUpTitle(title: "누적 리뷰 \(totalReviewCount)회")
        switch level {
        case .regular, .beginner, .prospect:
            let remainingReviewCount = level.nextLevel.levelUpTriggerCount - totalReviewCount
            descriptionLabel.setText(
                text: "'\(level.nextLevel.name)'까지 리뷰 \(remainingReviewCount)회가 남았어요",
                font: .bodyMedium
            )
        case .fancier:
            descriptionLabel.setText(text: "환경을 생각하는 가치 소비자!",
                                     font: .bodyMedium)
        }
    }

    private func layout() {
        [levelView, titleLabel].forEach { addSubview($0) }
        levelView.addSubview(backgroundView)
        [levelImage, levelLabel,
         descriptionLabel, remainingReviewTagView].forEach { backgroundView.addSubview($0) }

        levelView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(levelView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
        backgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(36)
        }
        levelImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.width.equalTo(120)
            $0.centerX.equalToSuperview()
        }
        levelLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(43)
        }
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(remainingReviewTagView.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(43)
        }
        remainingReviewTagView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
    }
}
