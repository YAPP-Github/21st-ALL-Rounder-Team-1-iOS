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
        return label
    }()

    private let writtenDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let reviewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
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
        profileImageView.image = UIImage(systemName: "person") // 서버연결 작업 후 fetch로직 통해 받아올 예정
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
            profile.leading.top.equalTo(contentView).inset(10)
        }

        userNameLabel.snp.makeConstraints { nameLabel in
            nameLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            nameLabel.top.trailing.equalTo(contentView).inset(10)
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
            reviewImage.leading.trailing.equalTo(contentView).inset(10)
            reviewImage.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
            reviewImage.height.equalTo(100)
        }

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.bottom.equalTo(contentView).inset(10)
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
        }
    }
}
