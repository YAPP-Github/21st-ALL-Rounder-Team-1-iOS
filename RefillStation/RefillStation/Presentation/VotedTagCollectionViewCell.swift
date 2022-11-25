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
        progressView.progressTintColor = .systemGray
        progressView.trackTintColor = .systemGray3
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
        setUpContentView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReview: TagReview, totalVoteCount: Int) {
        let percentage = Float(tagReview.voteCount) / Float(totalVoteCount)
        chartBar.progress = percentage
        reviewTitleLabel.text = tagReview.tagTitle
        voteCountLabel.text = "\(tagReview.voteCount)"
    }

    private func setUpContentView() {
        contentView.layer.cornerRadius = 5 // FIXME: 메서드 따로 분리
        contentView.clipsToBounds = true
    }

    private func layout() {

        [chartBar, reviewTitleLabel, voteCountLabel].forEach { contentView.addSubview($0) }

        chartBar.snp.makeConstraints { bar in
            bar.edges.equalTo(contentView)
        }

        reviewTitleLabel.snp.makeConstraints { title in
            title.top.bottom.equalTo(contentView)
            title.leading.equalTo(contentView).inset(5)
        }

        voteCountLabel.snp.makeConstraints { vote in
            vote.top.bottom.equalTo(contentView)
            vote.trailing.equalTo(contentView).inset(5)
        }
    }
}
