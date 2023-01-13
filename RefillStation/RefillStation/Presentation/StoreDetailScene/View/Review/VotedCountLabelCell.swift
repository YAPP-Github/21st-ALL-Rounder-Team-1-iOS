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
        label.text = "이 매장의 좋은점"
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

    private let profileGroupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.profileImageGroup.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(totalVote: Int) {
        if totalVote < 10 {
            profileGroupImageView.isHidden = true
            votedCountLabel.text = "현재까지 \(totalVote)명 "
        } else {
            votedCountLabel.text = "\(totalVote)명 "
        }
    }

    private func layout() {
        [titleLabel, votedCountLabel, participateLabel, profileGroupImageView].forEach { contentView.addSubview($0) }

        titleLabel.snp.makeConstraints { title in
            title.leading.top.bottom.equalToSuperview().inset(16)
        }

        participateLabel.snp.makeConstraints { vote in
            vote.trailing.top.bottom.equalToSuperview().inset(16)
        }

        votedCountLabel.snp.makeConstraints { count in
            count.trailing.equalTo(participateLabel.snp.leading)
            count.top.bottom.equalToSuperview().inset(16)
        }

        profileGroupImageView.snp.makeConstraints {
            $0.trailing.equalTo(votedCountLabel.snp.leading).offset(-4)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
}
