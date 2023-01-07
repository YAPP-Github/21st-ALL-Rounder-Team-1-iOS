//
//  VotedTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class VotedTagCell: UICollectionViewCell {

    static let reuseIdentifier = "votedTagCell"

    private let firstRankView: FirstRankView = {
        let firstRankView = FirstRankView()
        firstRankView.setUpContents(tagReview: TagReview(
            tag: Tag(image: UIImage(), title: "점원이 친절해요"),
            recommendedCount: 10
        ))
        return firstRankView
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray0.color
        return line
    }()

    private let otherClassStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setUpContentView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReviews: [TagReview]) {
        if tagReviews.isEmpty {
            [firstRankView, divisionLine, otherClassStackView].forEach { $0.isHidden = true }
            return
        } else {
            guard let first = tagReviews.first else { return }
            firstRankView.setUpContents(tagReview: first)
        }

        if tagReviews.count < 10 {
            [divisionLine, otherClassStackView].forEach { $0.isHidden = true }
            makeBlurPlaceholder()
        } else {
            for index in 1..<4 {
                let other = OtherRankView()
                other.setUpContents(tagReview: tagReviews[index], rank: index + 1)
                otherClassStackView.addArrangedSubview(other)
            }
        }
    }

    private func layout() {
        [firstRankView, divisionLine, otherClassStackView].forEach { contentView.addSubview($0) }

        firstRankView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(firstRankView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }

        otherClassStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(divisionLine.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(28)
        }
    }

    private func setUpContentView() {
        contentView.backgroundColor = Asset.Colors.gray0.color
        contentView.layer.cornerRadius = 16
    }

    private func makeBlurPlaceholder() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 16
        visualEffectView.clipsToBounds = true

        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "10명 이상 참여하시면 \n 공개됩니다!"
        label.font = UIFont.font(style: .bodyMedium)

        let labelView = UIView()
        labelView.addSubview(label)
        labelView.layer.cornerRadius = 6
        labelView.backgroundColor = .white
        labelView.layer.shadowRadius = 6
        labelView.layer.shadowColor = UIColor.black.cgColor
        labelView.layer.shadowOffset = CGSize(width: 0, height: 3)
        labelView.layer.shadowOpacity = 0.5
        labelView.layer.masksToBounds = false

        [visualEffectView, labelView].forEach { contentView.addSubview($0) }
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        labelView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(230)
            $0.height.equalTo(110)
        }

        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

fileprivate final class FirstRankView: UIView {

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray0.color
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 85 / 2
        return imageView
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1순위"
        label.backgroundColor = Asset.Colors.primary2.color
        label.layer.cornerRadius = 4
        label.textColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        return label
    }()

    private let rankTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReview: TagReview) {
        tagImageView.image = tagReview.tag.image
        titleLabel.text = tagReview.tag.title
    }

    private func layout() {
        [tagImageView, rankTitleStackView].forEach { addSubview($0) }
        tagImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(85)
        }

        [rankLabel, titleLabel].forEach { rankTitleStackView.addArrangedSubview($0) }

        rankTitleStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tagImageView.snp.bottom).offset(10)
        }

        rankLabel.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.width.equalTo(40)
        }
    }
}

fileprivate final class OtherRankView: UIView {

    private let divisionLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Asset.Colors.gray2.color
        return view
    }()
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        return label
    }()
    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonMedium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReview: TagReview, rank: Int) {
        rankLabel.text = "\(rank)순위"
        titleLabel.text = tagReview.tag.title
        tagImageView.image = tagReview.tag.image
    }

    private func layout() {
        [rankLabel, tagImageView, titleLabel].forEach { addSubview($0) }

        rankLabel.setContentHuggingPriority(.required, for: .horizontal)
        rankLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        tagImageView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(13)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(tagImageView.snp.height)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(tagImageView.snp.trailing).offset(10)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
}
