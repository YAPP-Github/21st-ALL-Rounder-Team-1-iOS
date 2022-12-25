//
//  FirstReviewRequestCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit
import SnapKit

final class FirstReviewRequestCell: UICollectionViewCell {
    static let reuseIdentifier = "firstReviewRequestCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "zzz")
        return imageView
    }()
    private let reviewRequestLabel: UILabel = {
        let label = UILabel()
        label.text = "리필스테이션 매장이름'의 첫 리뷰를 남겨주세요!"
        label.font = UIFont.font(style: .bodySmall)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [imageView, reviewRequestLabel].forEach { contentView.addSubview($0) }

        imageView.snp.makeConstraints { image in
            image.centerX.equalToSuperview()
            image.width.height.equalTo(90)
            image.top.equalToSuperview().inset(40)
        }

        reviewRequestLabel.snp.makeConstraints { review in
            review.top.equalTo(imageView.snp.bottom).offset(20)
            review.centerX.equalToSuperview()
        }
    }
}
