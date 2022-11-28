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

    private let imageView = UIImageView(image: UIImage(systemName: "zzz"))
    private let reviewRequestLabel: UILabel = {
        let label = UILabel()
        label.text = "리필스테이션 매장이름'의 첫 리뷰를 남겨주세요!"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [imageView, reviewRequestLabel].forEach { contentView.addSubview($0) }

        imageView.snp.makeConstraints { image in
            image.centerX.equalToSuperview()
            image.width.height.equalTo(90)
        }

        reviewRequestLabel.snp.makeConstraints { review in
            review.top.equalTo(imageView.snp.bottom)
            review.centerX.equalToSuperview()
        }
    }
}
