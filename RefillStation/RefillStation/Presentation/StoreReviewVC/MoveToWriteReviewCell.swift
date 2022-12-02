//
//  WriteReviewButtonCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class MoveToWriteReviewCell: UICollectionViewCell {

    static let reuseIdentifier  = "writeReviewButtonCell"

    private let moveToWritingReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰 남기기 ✎"
        label.textAlignment = .center
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.primary3.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.primary3.color.cgColor
        contentView.layer.cornerRadius = 6
    }

    private func layout() {
        contentView.addSubview(moveToWritingReviewLabel)
        moveToWritingReviewLabel.snp.makeConstraints { label in
            label.edges.equalToSuperview()
        }
    }
}
