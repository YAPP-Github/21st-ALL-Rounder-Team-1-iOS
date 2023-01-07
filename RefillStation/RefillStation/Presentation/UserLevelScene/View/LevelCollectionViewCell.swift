//
//  LevelCollectionViewCell.swift
//  RefillStation
//
//  Created by kong on 2023/01/06.
//

import UIKit
import SnapKit

class LevelCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "levelCollectionViewCell"

    private let levelContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = Asset.Colors.gray1.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let levelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Asset.Colors.lv1.color
        return imageView
    }()
    private let levelTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleSmall)
        return label
    }()
    private let levelTagView: PumpTagView = {
        let tagView = PumpTagView()
        return tagView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(levelContentView)
        [levelImageView, levelTitleLabel, levelTagView].forEach { levelContentView.addSubview($0) }
        levelContentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
        levelImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(levelImageView.snp.height)
        }
        levelTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalTo(levelImageView.snp.trailing).offset(12)
        }
        levelTagView.snp.makeConstraints {
            $0.top.equalTo(levelTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(levelImageView.snp.trailing).offset(12)
        }
    }

    func setUpContent(level: UserLevelInfo.Level) {
        levelTitleLabel.text = level.rawValue
        switch level {
        case .regular:
            levelTitleLabel.textColor = Asset.Colors.gray6.color
            levelTagView.setTitle("리뷰 0회")
        case .beginner:
            levelTitleLabel.textColor = Asset.Colors.lv1.color
            levelTagView.setTitle("리뷰 1회 이상")
        case .prospect:
            levelTitleLabel.textColor = Asset.Colors.lv2.color
            levelTagView.setTitle("리뷰 3회 이상")
        case .fancier:
            levelTitleLabel.textColor = Asset.Colors.lv3.color
            levelTagView.setTitle("리뷰 5회 이상")
        }
    }
}
