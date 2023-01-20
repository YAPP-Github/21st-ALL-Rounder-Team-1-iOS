//
//  LevelCollectionViewCell.swift
//  RefillStation
//
//  Created by kong on 2023/01/06.
//

import UIKit
import SnapKit

final class LevelCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LevelCollectionViewCell.self)

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

    func setUpContent(level: UserLevelInfo.Level) {
        levelTitleLabel.text = level.name
        levelTitleLabel.textColor = level.color
        levelTagView.setUpTitle(title: level.standard)
    }

    private func layout() {
        contentView.addSubview(levelContentView)
        [levelImageView, levelTitleLabel, levelTagView].forEach { levelContentView.addSubview($0) }
        levelContentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        levelImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(15)
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
}
