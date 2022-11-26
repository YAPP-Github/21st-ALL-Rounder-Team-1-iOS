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
        label.text = "방문하셨다면 리뷰를 남겨주세요! ✏️"
        label.textAlignment = .center
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
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 3
    }

    private func layout() {
        contentView.addSubview(moveToWritingReviewLabel)
        moveToWritingReviewLabel.snp.makeConstraints { label in
            label.edges.equalToSuperview()
        }
    }
}
