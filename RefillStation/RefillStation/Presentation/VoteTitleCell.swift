//
//  VoteTitleCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class VoteTitleCell: UICollectionViewCell {

    static let reuseIdentifier = "voteTitleCell"

    private let voteTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let maximumVoteLabel: UILabel = {
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

    private func layout() {
        [voteTitleLabel, maximumVoteLabel].forEach {
            contentView.addSubview($0)
        }

        voteTitleLabel.snp.makeConstraints { titleLabel in
            titleLabel.leading.top.bottom.equalToSuperview().inset(5)
        }

        maximumVoteLabel.snp.makeConstraints { voteLabel in
            voteLabel.leading.equalTo(voteTitleLabel.snp.trailing).inset(5)
            voteLabel.trailing.top.bottom.equalToSuperview().inset(5)
        }
    }
}
