//
//  VotedTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class VotedTagCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "votedTagCollectionViewCell"

    private let chartBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        return progressView
    }()

    private let reviewTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let voteCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setContents(tagReview: TagReview, totalVoteCount: Int) {
        let percentage = Float(tagReview.voteCount / totalVoteCount)
        chartBar.progress = percentage
        reviewTitleLabel.text = tagReview.tagTitle
        voteCountLabel.text = "\(tagReview.voteCount)"
    }

    private func layout() {
        [chartBar, reviewTitleLabel, voteCountLabel].forEach { contentView.addSubview($0) }

        chartBar.snp.makeConstraints { bar in
            bar.edges.equalTo(contentView)
        }

        reviewTitleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalTo(contentView)
        }

        voteCountLabel.snp.makeConstraints { vote in
            vote.trailing.top.bottom.equalTo(contentView)
        }
    }
}
