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
        return label
    }()

    private let totalVotePeopleLabel: UILabel = {
        let label = UILabel()
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
        totalVotePeopleLabel.text = "\(totalVote)명 참여"
    }

    private func layout() {
        [titleLabel, totalVotePeopleLabel].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalTo(self)
        }

        totalVotePeopleLabel.snp.makeConstraints { vote in
            vote.trailing.top.bottom.equalTo(self)
        }
    }
}
