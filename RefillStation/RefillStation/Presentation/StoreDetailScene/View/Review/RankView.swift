//
//  VotedTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class FirstRankView: UIView {

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray0.color
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 85 / 2
        return imageView
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1순위"
        label.backgroundColor = Asset.Colors.primary8.color
        label.layer.cornerRadius = 4
        label.textColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let rankTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tag: Tag) {
        tagImageView.image = tag.image
        titleLabel.text = tag.text
    }

    private func layout() {
        [tagImageView, rankTitleStackView].forEach { addSubview($0) }
        tagImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(85)
        }

        [rankLabel, titleLabel].forEach { rankTitleStackView.addArrangedSubview($0) }

        rankTitleStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tagImageView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }

        rankLabel.snp.makeConstraints {
            $0.width.equalTo(30)
        }
    }
}

final class OtherRankView: UIView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        label.font = .font(style: .captionMedium)
        return label
    }()
    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .buttonMedium)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tag: Tag, rank: Int) {
        rankLabel.text = "\(rank)순위"
        titleLabel.text = tag.text
        tagImageView.image = tag.image.withAlignmentRectInsets(
            .init(top: -4, left: -4, bottom: -4, right: -4))
    }

    private func layout() {
        [rankLabel, tagImageView, titleLabel].forEach { addSubview($0) }

        rankLabel.setContentHuggingPriority(.required, for: .horizontal)
        rankLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        tagImageView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(13)
            $0.top.bottom.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(tagImageView.snp.trailing).offset(2)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
}
