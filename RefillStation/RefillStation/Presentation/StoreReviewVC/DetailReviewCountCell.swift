//
//  DetailReviewCountCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

final class DetailReviewCountCell: UICollectionViewCell {

    static let reuseIdentifier = "detailReviewCountCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = UIFont.font(style: .titleMedium)
        return label
    }()

    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleMedium)
        label.textColor = Asset.Colors.primary3.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(totalDetailReviewCount: Int) {
        reviewCountLabel.text = "\(totalDetailReviewCount)"
    }

    private func layout() {
        [titleLabel, reviewCountLabel].forEach {
            contentView.addSubview($0)
        }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalToSuperview()
        }

        reviewCountLabel.snp.makeConstraints { count in
            count.leading.equalTo(titleLabel.snp.trailing).offset(5)
            count.top.bottom.equalToSuperview()
        }
    }
}
