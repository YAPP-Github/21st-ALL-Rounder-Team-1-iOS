//
//  DetailReviewTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class DetailReviewTagCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "detailReviewTagCollectionViewCell"

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
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

    func setUpContents(title: String) {
        tagTitleLabel.text = title
    }

    private func layout() {
        contentView.addSubview(tagTitleLabel)
        tagTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
