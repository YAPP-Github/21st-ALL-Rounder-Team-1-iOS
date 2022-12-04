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
        label.textColor = Asset.Colors.gray6.color
        label.textAlignment = .center
        return label
    }()

    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.primary2.color
        return label
    }()

    init(tagClass: TagClass) {
        self.tagClass = tagClass
        super.init(frame: .zero)
        setLabelFont()
        setUpSelf()
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

    private func setLabelFont() {
        [tagTitleLabel, voteCountLabel].forEach {
            if self.tagClass == .first {
                $0.font = UIFont.font(style: .titleSmall)
            } else {
                $0.font = .systemFont(ofSize: 12)
            }
        }
    }

    private func setUpSelf() {
        layer.cornerRadius = 6
        clipsToBounds = true
        backgroundColor = Asset.Colors.gray1.color
    }

    private func layout() {
        [tagImageView, tagTitleLabel, voteCountLabel].forEach {
            addSubview($0)
        }

        tagImageView.snp.makeConstraints { image in
            image.centerX.equalToSuperview()
        }

        addConstraintsWithTagClassOption()
    }

    private func addConstraintsWithTagClassOption() {
        if tagClass == .first {
            tagTitleLabel.snp.remakeConstraints { title in
                title.top.equalTo(tagImageView.snp.bottom).offset(10)
                title.centerX.equalToSuperview()
            }

            voteCountLabel.snp.makeConstraints { count in
                count.top.equalTo(tagTitleLabel.snp.top)
                count.leading.equalTo(tagTitleLabel.snp.trailing).offset(5)
            }

            tagImageView.snp.makeConstraints { image in
                image.centerY.equalToSuperview().multipliedBy(0.8)
            }

        } else {
            tagTitleLabel.snp.makeConstraints { title in
                title.top.equalTo(tagImageView.snp.bottom).offset(10)
                title.leading.trailing.equalToSuperview().inset(20)
            }

            voteCountLabel.snp.makeConstraints { count in
                count.top.equalTo(tagTitleLabel.snp.bottom).offset(5)
                count.centerX.equalToSuperview()
            }

            tagImageView.snp.makeConstraints { image in
                image.centerY.equalToSuperview().multipliedBy(0.7)
            }
        }
    }
}
