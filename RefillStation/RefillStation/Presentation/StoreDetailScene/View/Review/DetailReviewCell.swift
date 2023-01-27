//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: DetailReviewCell.self)

    var coordinator: StoreDetailCoordinator?

    // MARK: - Private Properties
    private var tags: [Tag]?
    private var review: Review?
    private let profileImageHeight: CGFloat = 40
    private var tagCollectionViewHeight: CGFloat = 40 {
        didSet {
            remakeTagCollectionViewConstraints()
        }
    }

    // MARK: - Event Handling
    override var isSelected: Bool {
        didSet {
            descriptionLabel.numberOfLines = isSelected ? 0 : 3
            layoutIfNeeded()
        }
    }
    var photoImageTapped: (() -> Void)?

    // MARK: - UI Components
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = profileImageHeight / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Asset.Colors.gray1.color
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

    private lazy var reviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped(_:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.backgroundColor = Asset.Colors.gray1.color
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

    private let imageCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonSmall)
        label.textColor = .white
        label.backgroundColor = Asset.Colors.gray3.color
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()

    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고", for: .normal)
        button.titleLabel?.font = .font(style: .captionLarge)
        button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            guard let self = self,
            let reportedUserId = self.review?.userId else { return }
            self.coordinator?.showReportPopUp(reportedUserId: reportedUserId)
        }, for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(review: Review) {
        self.tags = review.tags
        userNameLabel.text = review.userNickname
        writtenDateLabel.text = review.writtenDate.toString()
        descriptionLabel.text = review.description
        imageCountLabel.text = "1 / \(review.imageURL.count)"
        imageCountLabel.isHidden = review.imageURL.count <= 1
        remakeReviewImageViewConstraints(isReviewImageEmpty: review.imageURL.isEmpty)
        // TODO: Fetch Image(profile, review) with URL
        tagCollectionView.reloadData()
        tagCollectionView.layoutIfNeeded()
        tagCollectionViewHeight = tagCollectionView.contentSize.height
        layoutIfNeeded()
    }

    private func layout() {
        [profileImageView, userNameLabel, writtenDateLabel, reviewImageView,
         descriptionLabel, divisionLine, tagCollectionView, imageCountLabel, reportButton].forEach {
            contentView.addSubview($0)
        }

        profileImageView.snp.makeConstraints { profile in
            profile.leading.equalToSuperview().inset(16)
            profile.top.equalToSuperview().inset(20)
            profile.height.width.equalTo(profileImageHeight)
        }

        userNameLabel.snp.makeConstraints { nameLabel in
            nameLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            nameLabel.top.equalToSuperview().inset(20)
            nameLabel.trailing.equalTo(reportButton.snp.leading).offset(-10)
        }

        writtenDateLabel.snp.makeConstraints { dateLabel in
            dateLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            dateLabel.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }

        remakeReviewImageViewConstraints(isReviewImageEmpty: false)

        descriptionLabel.snp.makeConstraints { description in
            description.leading.trailing.equalToSuperview().inset(16)
            description.top.equalTo(reviewImageView.snp.bottom).offset(10)
            description.top.equalTo(writtenDateLabel.snp.bottom).offset(10).priority(.medium)
        }

        remakeTagCollectionViewConstraints()

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(tagCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        imageCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(reviewImageView).inset(14)
            $0.height.equalTo(20)
            $0.width.equalTo(42)
        }

        reportButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(21)
        }
    }

    private func remakeTagCollectionViewConstraints() {
        tagCollectionView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.height.equalTo(tagCollectionViewHeight)
        }
    }

    private func remakeReviewImageViewConstraints(isReviewImageEmpty: Bool) {
        if isReviewImageEmpty {
            reviewImageView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
                $0.height.equalTo(0)
            }
        } else {
            reviewImageView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.equalTo(writtenDateLabel.snp.bottom).offset(10)
                $0.height.equalTo(168).priority(.high)
            }
        }
    }

    @objc
    private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        photoImageTapped?()
    }
}

// MARK: - tagCollectionView Layout
extension DetailReviewCell {
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

// MARK: - tagCollectionView DataSource
extension DetailReviewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tags = tags,
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailReviewTagCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? DetailReviewTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpContents(tag: tags[indexPath.row])
        return cell
    }
}

// MARK: - Date Extension
fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: self)
    }
}
