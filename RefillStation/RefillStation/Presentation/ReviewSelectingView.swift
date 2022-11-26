//
//  ReviewSelectingView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class ReviewSelectingView: UIView {

    var viewModel: ReviewSelectingViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이 매장의 좋은 점은 무엇인가요?"
        return label
    }()

    private let maximumSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개"
        return label
    }()

    private let reviewSelectingCollectionView: ReviewSelectingCollectionView

    init(viewModel: ReviewSelectingViewModel) {
        self.viewModel = viewModel
        self.reviewSelectingCollectionView = ReviewSelectingCollectionView(viewModel: viewModel)
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        self.viewModel = ReviewSelectingViewModel()
        self.reviewSelectingCollectionView = ReviewSelectingCollectionView(viewModel: viewModel)
        super.init(coder: coder)
    }

    private func layout() {
        [titleLabel, maximumSelectLabel, reviewSelectingCollectionView].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.equalTo(self).inset(10)
        }

        maximumSelectLabel.snp.makeConstraints { maxLabel in
            maxLabel.leading.equalTo(titleLabel.snp.trailing).offset(10)
            maxLabel.top.trailing.equalTo(self).inset(10)
        }

        reviewSelectingCollectionView.snp.makeConstraints { collection in
            collection.top.equalTo(titleLabel.snp.bottom).offset(10)
            collection.leading.trailing.bottom.equalTo(self).inset(10)
        }
    }
}
