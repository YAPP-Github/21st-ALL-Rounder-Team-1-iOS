//
//  VotedCountLabelCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class VotedCountLabelCell: UICollectionViewCell {

    static let reuseIdentifier = "votedCountLabelCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleMedium)
        return label
    }()

    private let votedCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let participateLabel: UILabel = {
        let label = UILabel()
        label.text = "참여"
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpContents(totalVote: Int) {
        titleLabel.text = "이 매장의 좋은 점은"
        votedCountLabel.text = "\(totalVote)명 "
    }

    private func layout() {
        [titleLabel, votedCountLabel, participateLabel].forEach { contentView.addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalToSuperview()
        }

        participateLabel.snp.makeConstraints { vote in
            vote.trailing.top.bottom.equalToSuperview()
        }

        votedCountLabel.snp.makeConstraints { count in
            count.trailing.equalTo(participateLabel.snp.leading)
            count.top.bottom.equalToSuperview()
        }
    }
}
