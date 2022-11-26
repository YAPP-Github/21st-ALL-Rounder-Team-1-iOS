//
//  TagReviewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit

final class TagReviewCell: UICollectionViewCell {

    static let reuseIdentifier = "tagReviewCell"

    private var reviewSelectingCollectionView: ReviewSelectingCollectionView!

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    init(viewModel: ReviewSelectingViewModel) {
        super.init(frame: .zero)
        reviewSelectingCollectionView = ReviewSelectingCollectionView(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(reviewSelectingCollectionView)
        reviewSelectingCollectionView.snp.makeConstraints { collection in
            collection.edges.equalToSuperview()
        }
    }
}
