//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: DetailReviewCell.self)

    override var isSelected: Bool {
        didSet {
            if isSelected {
                descriptionLabel.numberOfLines = 0
            } else {
                descriptionLabel.numberOfLines = 3
            }
            layoutIfNeeded()
        }
    }

    private var detailReview: DetailReview?

    private let profileImageHeight: CGFloat = 40
    private var tagCollectionViewHeight: CGFloat = 40 {
        didSet {
            remakeTagCollectionViewConstraints()
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
        label.lineBreakStrategy = .hangulWordPriority
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

    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        tagCollectionViewHeight = tagCollectionView.contentSize.height
        layoutIfNeeded()
    }

    private func layout() {
        [profileImageView, userNameLabel, writtenDateLabel, reviewImageView,
         descriptionLabel, divisionLine, tagCollectionView].forEach {
            contentView.addSubview($0)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.leading.equalToSuperview().inset(16)
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

        reviewImageView.snp.makeConstraints { reviewImage in
            reviewImage.leading.trailing.equalToSuperview().inset(16)
            reviewImage.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
            reviewImage.height.equalTo(168)
        }

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.equalToSuperview().inset(16)
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
        }

        remakeTagCollectionViewConstraints()

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }

    private func remakeTagCollectionViewConstraints() {
        tagCollectionView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.height.equalTo(tagCollectionViewHeight)
        }
    }

    private func tagCollectionLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(70))
        )
        item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70)),
            subitems: [item]
        )

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
