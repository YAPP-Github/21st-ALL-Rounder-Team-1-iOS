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

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let totalVotePeopleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var tagCollectionView = VotedTagCollectionView(viewModel: viewModel)

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

    private func layout() {
        [titleLabel, totalVotePeopleLabel, tagCollectionView].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.equalTo(self)
        }

        totalVotePeopleLabel.snp.makeConstraints { vote in
            vote.top.trailing.equalTo(self)
        }

        tagCollectionView.snp.makeConstraints { collection in
            collection.top.equalTo(titleLabel.snp.bottom).offset(10)
            collection.leading.trailing.bottom.equalTo(self)
        }
    }

    private func setUpContents() {
        titleLabel.text = "이 매장의 좋은 점은"
        totalVotePeopleLabel.text = "\(viewModel.totalVoteCount)명 참여"
    }
}
