//
//  TagReviewView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class TagReviewView: UIView {

    let viewModel: TagReviewViewModel

    private var collectionViewHeightThatFits: CGFloat = 200

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let totalVotePeopleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var tagCollectionView = VotedTagCollectionView(viewModel: viewModel)

    init(viewModel: TagReviewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        layout()
        setUpContents()
    }

    required init?(coder: NSCoder) {
        self.viewModel = TagReviewViewModel()
        super.init(coder: coder)
    }

    func makeViewFitToContent() {
        let tagCollectionViewLayout = tagCollectionView.collectionViewLayout
        let contentHeight = tagCollectionViewLayout.collectionViewContentSize.height
        collectionViewHeightThatFits = contentHeight
        layout()
    }

    private func layout() {
        [titleLabel, totalVotePeopleLabel, tagCollectionView].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.equalTo(self)
        }

        totalVotePeopleLabel.snp.makeConstraints { vote in
            vote.top.trailing.equalTo(self)
        }

        tagCollectionView.snp.remakeConstraints { collection in
            collection.top.equalTo(titleLabel.snp.bottom).offset(10)
            collection.leading.trailing.bottom.equalTo(self)
            collection.height.equalTo(collectionViewHeightThatFits)
        }
    }

    private func setUpContents() {
        titleLabel.text = "이 매장의 좋은 점은"
        totalVotePeopleLabel.text = "\(viewModel.totalVoteCount)명 참여"
    }
}
