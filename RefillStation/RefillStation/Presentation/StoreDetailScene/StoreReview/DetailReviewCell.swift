//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCell: UICollectionViewCell {
    static let reuseIdentifier = "detailReviewCell"

    private let profileImageHeight: CGFloat = 40

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = profileImageHeight / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
        imageView.contentMode = .scaleAspectFill
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

    func setUpImages(userImage: UIImage, reviewImage: UIImage) {
        profileImageView.image = userImage
        reviewImageView.image = reviewImage
    }

    func setUpContents(detailReview: DetailReview) {
        profileImageView.image = UIImage(systemName: "person")
        userNameLabel.text = detailReview.user.name
        writtenDateLabel.text = detailReview.writtenDate.toString()
        reviewImageView.image = UIImage(systemName: "zzz")
        descriptionLabel.text = detailReview.description
    }

    private func layout() {
        [profileImageView, userNameLabel, writtenDateLabel, reviewImageView, descriptionLabel].forEach {
            contentView.addSubview($0)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.leading.top.equalTo(contentView)
            profile.height.width.equalTo(profileImageHeight)
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
            profile.width.height.equalTo(profileImageHeight)
        }

        reviewImageView.snp.makeConstraints { reviewImage in
            reviewImage.leading.trailing.equalTo(contentView)
            reviewImage.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
            reviewImage.height.equalTo(168)
        }

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.bottom.equalToSuperview()
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
        }
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: self)
    }
}
