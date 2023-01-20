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

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleLarge2)
        label.textAlignment = .center
        return label
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
        label.text = "회원 등급 자세히 보기"
        label.font = .font(style: .titleSmall)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(nickname: String,
                       level: UserLevelInfo.Level,
                       remainingCount: Int,
                       totalCount: Int) {
        nicknameLabel.text = "\(nickname)님은"
        descriptionLabel.text = "'\(level.name)'까지 리뷰 \(remainingCount)회가 남았어요"
        levelLabel.text = level.name
        remainingReviewTagView.setUpTagView(level: .regular, title: "누적 리뷰 \(totalCount)회")
    }

    private func layout() {
        [levelView, titleLabel].forEach { addSubview($0) }
        levelView.addSubview(backgroundView)
        [levelImage, nicknameLabel, levelLabel, descriptionLabel, remainingReviewTagView].forEach { backgroundView.addSubview($0) }

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
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(levelImage.snp.bottom).offset(12)
            $0.bottom.equalTo(levelLabel.snp.top)
            $0.leading.trailing.equalToSuperview().inset(43)
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
