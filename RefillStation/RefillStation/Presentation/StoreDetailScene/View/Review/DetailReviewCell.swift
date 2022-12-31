//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCell: UICollectionViewCell {

    static let reuseIdentifier = "detailReviewCell"
    private var detailReview: DetailReview?

    private let profileImageHeight: CGFloat = 40
    private var tagCollectionViewheight: CGFloat = 40 {
        didSet {
            tagCollectionViewLayout()
        }
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = profileImageHeight / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()

    private let writtenDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .captionLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    private let reviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodyMedium)
        return label
    }()

    private lazy var tagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCollectionLayout())
        collectionView.dataSource = self
        collectionView.register(
            DetailReviewTagCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailReviewTagCollectionViewCell.reuseIdentifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = Asset.Colors.gray5.color
        button.addTarget(self, action: #selector(seeMoreButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    var reloadCell: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc
    private func seeMoreButtonTapped(_ sender: UIButton) {
        reloadCell?()
    }

    func setUpSeeMore(shouldSeeMore: Bool) {
        descriptionLabel.numberOfLines = shouldSeeMore ? 0 : 3
        seeMoreButton.isHidden = shouldSeeMore
    }

    func setUpImages(userImage: UIImage, reviewImage: UIImage) {
        profileImageView.image = userImage
        reviewImageView.image = reviewImage
    }

    func setUpContents(detailReview: DetailReview) {
        self.detailReview = detailReview
        profileImageView.image = UIImage(systemName: "person")
        userNameLabel.text = detailReview.user.name
        writtenDateLabel.text = detailReview.writtenDate.toString()
        reviewImageView.image = UIImage(systemName: "zzz")
        descriptionLabel.text = detailReview.description
        tagCollectionView.reloadData()
        tagCollectionView.layoutIfNeeded()
        tagCollectionViewheight = tagCollectionView.contentSize.height
        layoutIfNeeded()
    }

    private func layout() {
        [profileImageView, userNameLabel, writtenDateLabel, reviewImageView,
         descriptionLabel, divisionLine, tagCollectionView, seeMoreButton].forEach {
            contentView.addSubview($0)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.leading.equalToSuperview()
            profile.top.equalToSuperview().inset(20)
            profile.height.width.equalTo(profileImageHeight)
        }

        userNameLabel.snp.makeConstraints { nameLabel in
            nameLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            nameLabel.top.trailing.equalToSuperview().inset(20)
        }

        writtenDateLabel.snp.makeConstraints { dateLabel in
            dateLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            dateLabel.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.top.equalTo(userNameLabel.snp.top)
            profile.bottom.equalTo(writtenDateLabel.snp.bottom)
            profile.width.height.equalTo(profileImageHeight)
        }

        reviewImageView.snp.makeConstraints { reviewImage in
            reviewImage.leading.trailing.equalTo(contentView)
            reviewImage.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
            reviewImage.height.equalTo(168)
        }

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.equalToSuperview()
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
        }

        tagCollectionViewLayout()

        seeMoreButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.trailing.equalTo(descriptionLabel.snp.trailing)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func tagCollectionViewLayout() {
        tagCollectionView.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(seeMoreButton.snp.bottom).offset(10)
            $0.height.equalTo(tagCollectionViewheight)
        }
    }

    private func tagCollectionLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(40), heightDimension: .estimated(40))
        )
        item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)),
            subitems: [item]
        )
        group.interItemSpacing = .fixed(10)
        return UICollectionViewCompositionalLayout(section: .init(group: group))
    }
}

extension DetailReviewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailReview?.tags.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailReview = detailReview,
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailReviewTagCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? DetailReviewTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpContents(tag: detailReview.tags[indexPath.row].tag)
        return cell
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: self)
    }
}
