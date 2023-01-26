//
//  ReviewInfoCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/14.
//

import UIKit

final class ReviewInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ReviewInfoCell.self)

    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private let didVisitedLabel: UILabel = {
        let label = UILabel()
        label.text = "매장에 방문한 적이 있다면?"
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodySmall)
        return label
    }()

    private let moveToRegisterReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 쓰기", for: .normal)
        button.titleLabel?.font = UIFont.font(style: .buttonMedium)
        button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        button.setImage(Asset.Images.iconEdit.image, for: .normal)
        button.tintColor = Asset.Colors.gray6.color
        button.semanticContentAttribute = .forceRightToLeft
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    private lazy var registerReviewView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.primary1.color
        view.layer.cornerRadius = 4
        [didVisitedLabel, moveToRegisterReviewButton].forEach { view.addSubview($0) }
        didVisitedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        moveToRegisterReviewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        return view
    }()

    private let storeStrengthLabel: UILabel = {
        let label = UILabel()
        label.text = "이 매장의 좋은점"
        label.font = UIFont.font(style: .titleMedium)
        return label
    }()

    private let profileGroupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.profileImageGroup.image
        imageView.contentMode = .scaleAspectFit
        return imageView
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

    private lazy var tagVoteCountView: UIView = {
        let view = UIView()
        [storeStrengthLabel, profileGroupImageView, votedCountLabel, participateLabel].forEach { view.addSubview($0) }
        storeStrengthLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }

        participateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }

        votedCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(participateLabel.snp.leading)
            $0.top.bottom.equalToSuperview().inset(8)
        }

        profileGroupImageView.snp.makeConstraints {
            $0.trailing.equalTo(votedCountLabel.snp.leading).offset(-4)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        return view
    }()

    private let firstRankView: FirstRankView = {
        let firstRankView = FirstRankView()
        firstRankView.setUpContents(tag: Tag.clerkIsKind)
        return firstRankView
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray2.color
        return line
    }()

    private let otherClassStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var tagReviewRankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Asset.Colors.gray0.color
        [firstRankView, divisionLine, otherClassStackView].forEach { view.addSubview($0) }

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
        return view
    }()

    private let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = UIFont.font(style: .titleMedium)
        return label
    }()

    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleMedium)
        label.textColor = Asset.Colors.primary3.color
        return label
    }()

    private lazy var reviewCountView: UIView = {
        let view = UIView()
        [reviewTextLabel, reviewCountLabel].forEach { view.addSubview($0) }
        reviewTextLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewTextLabel.snp.trailing)
            $0.top.bottom.equalToSuperview()
        }
        return view
    }()

    var moveToRegisterReview: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        addMoveToRegisterReviewAction()
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

    func setUpContents(totalDetailReviewCount: Int) {
        reviewCountLabel.text = "\(totalDetailReviewCount)"
    }

    func setUpContents(reviews: [Review]) {

        // TODO: 로직 제작
//        if reviews.isEmpty {
//            [firstRankView, divisionLine, otherClassStackView].forEach { $0.isHidden = true }
//            return
//        } else {
//            guard let first = reviews.first else { return }
//            firstRankView.setUpContents(tagReview: first)
//        }
//
//        if reviews.count < 10 {
//            [divisionLine, otherClassStackView].forEach { $0.isHidden = true }
//            makeBlurPlaceholder()
//        } else {
//            while otherClassStackView.arrangedSubviews.count < 3 {
//                let other = OtherRankView()
//                let index = otherClassStackView.arrangedSubviews.count
//                other.setUpContents(tagReview: reviews[index], rank: index + 2)
//                otherClassStackView.addArrangedSubview(other)
//            }
//        }
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

        [visualEffectView, labelView].forEach { tagReviewRankView.addSubview($0) }
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        labelView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(53)
        }

        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func layout() {
        contentView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        [registerReviewView, tagVoteCountView, tagReviewRankView, reviewCountView].forEach {
            outerStackView.addArrangedSubview($0)
        }
    }

    private func addMoveToRegisterReviewAction() {
        moveToRegisterReviewButton.addAction(UIAction { _ in
            self.moveToRegisterReview?()
        }, for: .touchUpInside)
    }
}
