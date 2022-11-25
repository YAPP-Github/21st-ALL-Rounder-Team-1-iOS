//
//  DetailReviewTableViewHeader.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

class DetailReviewTableViewHeader: UITableViewHeaderFooterView {

    static let reuseIdentifier = "detailReviewTableViewHeader"

    private var viewModel = VotedTagViewModel()

    private var votedTagCollectionView: VotedTagCollectionView!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setMockViewModel()
        initializeTagReviewView()
        layout()
    }

    required init?(coder: NSCoder) {
        viewModel = VotedTagViewModel()
        super.init(coder: coder)
    }

    private func setMockViewModel() {
        let viewModel = VotedTagViewModel()
        viewModel.totalVoteCount = 10
        viewModel.tagReviews = [
            .init(tagTitle: "청결해요", voteCount: 5),
            .init(tagTitle: "친절해요", voteCount: 6),
            .init(tagTitle: "배고파요", voteCount: 7),
            .init(tagTitle: "살려줘요", voteCount: 8)
        ]

        self.viewModel = viewModel
    }

    private func initializeTagReviewView() {
        votedTagCollectionView = VotedTagCollectionView(viewModel: viewModel)
    }

    private func layout() {
        contentView.addSubview(votedTagCollectionView)
        votedTagCollectionView.snp.makeConstraints { collection in
            collection.edges.equalToSuperview().inset(10)
        }
    }
}
