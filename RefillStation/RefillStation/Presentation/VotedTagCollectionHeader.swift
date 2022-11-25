//
//  VotedTagCollectionHeader.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class VotedTagCollectionHeader: UICollectionReusableView {

    static let reuseIdentifier = "votedTagCollectionHeader"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이 매장의 좋은 점은"
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
        super.init(coder: coder)
    }

    func setUpContents(totalVote: Int) {
        totalVotePeopleLabel.text = "\(totalVote)명 참여"
    }

    private func layout() {
        [titleLabel, totalVotePeopleLabel].forEach { addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalTo(self).inset(10)
        }

        totalVotePeopleLabel.snp.makeConstraints { vote in
            vote.trailing.top.bottom.equalTo(self).inset(10)
        }
    }
}
