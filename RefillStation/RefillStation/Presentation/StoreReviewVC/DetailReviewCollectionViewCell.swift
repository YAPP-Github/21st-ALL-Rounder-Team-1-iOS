//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "detailReviewTableViewCell"

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()

    private let writtenDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .captionLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    private let reviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodyMedium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(detailReview: DetailReview) {
        profileImageView.image = UIImage(systemName: "person")
        userNameLabel.text = detailReview.user.name
        writtenDateLabel.text = detailReview.writtenDate.description
        reviewImageView.image = UIImage(systemName: "zzz")
        descriptionLabel.text = detailReview.description
    }

    private func layout() {
        [profileImageView, userNameLabel, writtenDateLabel, reviewImageView, descriptionLabel].forEach {
            contentView.addSubview($0)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.leading.top.equalTo(contentView)
        }

        userNameLabel.snp.makeConstraints { nameLabel in
            nameLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            nameLabel.top.trailing.equalTo(contentView)
        }

        writtenDateLabel.snp.makeConstraints { dateLabel in
            dateLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            dateLabel.top.equalTo(userNameLabel.snp.bottom).offset(5)

        }

        profileImageView.snp.makeConstraints { profile in
            profile.top.equalTo(userNameLabel.snp.top)
            profile.bottom.equalTo(writtenDateLabel.snp.bottom)
            profile.width.equalTo(profileImageView.snp.height)
        }

        reviewImageView.snp.makeConstraints { reviewImage in
            reviewImage.leading.trailing.equalTo(contentView)
            reviewImage.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
            reviewImage.height.equalTo(100)
        }

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.bottom.equalTo(contentView)
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
        }
    }
}
