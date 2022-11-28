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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        layout()
    }

    private let firstClassBox = VotedTagReviewBox(tagClass: .first)
    private let secondClassBox = VotedTagReviewBox(tagClass: .other)
    private let thirdClassBox = VotedTagReviewBox(tagClass: .other)
    private let forthClassBox = VotedTagReviewBox(tagClass: .other)

    private let otherClassStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReviews: [TagReview]) {
        let classes = [firstClassBox, secondClassBox, thirdClassBox, forthClassBox]

        for index in 0..<tagReviews.count {
            classes[index].setUpContents(tagReview: tagReviews[index])
        }
    }

    private func setUpContentView() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }

    private func layout() {
        [firstClassBox, otherClassStackView].forEach {
            contentView.addSubview($0)
        }

        firstClassBox.snp.makeConstraints { first in
            first.leading.top.trailing.equalToSuperview()
            first.height.equalToSuperview().multipliedBy(0.5)
        }

        otherClassStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(firstClassBox.snp.bottom).offset(10)
            stackView.leading.bottom.trailing.equalToSuperview()
        }

        [secondClassBox, thirdClassBox, forthClassBox].forEach {
            otherClassStackView.addArrangedSubview($0)
        }
    }
}

final class VotedTagReviewBox: UIView {

    enum TagClass {
        case first
        case other
    }

    private let tagClass: TagClass

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let voteCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    init(tagClass: TagClass) {
        self.tagClass = tagClass
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        self.tagClass = .other
        super.init(coder: coder)
    }

    func setUpContents(tagReview: TagReview) {
        tagImageView.image = tagReview.image
        tagTitleLabel.text = tagReview.tagTitle
        voteCountLabel.text = "\(tagReview.voteCount)"
    }

    private func layout() {
        [tagImageView, tagTitleLabel, voteCountLabel].forEach {
            addSubview($0)
        }

        tagImageView.snp.makeConstraints { image in
            image.centerX.equalToSuperview()
        }

        tagTitleLabel.snp.makeConstraints { title in
            title.top.equalTo(tagImageView.snp.bottom).offset(15)
            title.centerX.equalToSuperview()
        }

        addVoteCountLabelConstraints()
    }

    private func addVoteCountLabelConstraints() {
        if tagClass == .first {
            voteCountLabel.snp.makeConstraints { count in
                count.top.equalTo(tagTitleLabel.snp.top)
                count.leading.equalTo(tagTitleLabel.snp.trailing).offset(5)
            }
        } else {
            voteCountLabel.snp.makeConstraints { count in
                count.top.equalTo(tagTitleLabel.snp.bottom).offset(5)
                count.centerX.equalToSuperview()
            }
        }
    }
}
