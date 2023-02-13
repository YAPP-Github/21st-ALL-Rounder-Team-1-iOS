//
//  DetailReviewCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class DetailReviewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: DetailReviewCell.self)

    // MARK: - Private Properties
    private var review: Review?
    private var tags: [Tag]?
    private var tagCollectionViewHeight: CGFloat = 40
    private var profileImageLoadTask: Cancellable?
    private var reviewImageLoadTask: Cancellable?

    // MARK: - Event Handling
    var photoImageTapped: (() -> Void)?
    var reportButtonTapped: (() -> Void)?
    var seeMoreTapped: (() -> Void)?

    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Asset.Colors.gray1.color
        imageView.layer.cornerRadius = 19
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

    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고", for: .normal)
        button.titleLabel?.font = .font(style: .captionLarge)
        button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.reportButtonTapped?()
        }, for: .touchUpInside)
        button.contentEdgeInsets = .init(top: .leastNormalMagnitude, left: .leastNormalMagnitude,
                                         bottom: .leastNormalMagnitude, right: .leastNormalMagnitude)
        return button
    }()

    private lazy var reviewInfoView: UIView = {
        let reviewInfoView = UIView()
        [profileImageView, userNameLabel, writtenDateLabel, reportButton].forEach { reviewInfoView.addSubview($0) }
        profileImageView.snp.makeConstraints { profile in
            profile.leading.equalToSuperview()
            profile.top.bottom.equalToSuperview()
            profile.height.equalToSuperview()
            profile.width.equalTo(profileImageView.snp.height)
        }

        userNameLabel.snp.makeConstraints { nameLabel in
            nameLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            nameLabel.top.trailing.equalToSuperview()
        }

        writtenDateLabel.snp.makeConstraints { dateLabel in
            dateLabel.leading.equalTo(profileImageView.snp.trailing).offset(10)
            dateLabel.top.equalTo(userNameLabel.snp.bottom).offset(5)
            dateLabel.bottom.equalToSuperview().inset(5)
        }

        reportButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
        }
        reportButton.setContentHuggingPriority(.required, for: .vertical)
        return reviewInfoView
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

    private let imageCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonSmall)
        label.textColor = .white
        label.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0.2)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()

    private lazy var reviewImageOuterView: UIView = {
        let reviewImageOuterView = UIView()
        [reviewImageView, imageCountLabel].forEach { reviewImageOuterView.addSubview($0) }
        reviewImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }

        imageCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(reviewImageView).inset(14)
            $0.height.equalTo(20)
            $0.width.equalTo(42)
        }
        return reviewImageOuterView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodyMediumOverTwoLine)
        label.lineBreakMode = .byTruncatingTail
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(descriptionLabelTapped(_:)))
        label.addGestureRecognizer(tapGesture)
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

    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        [profileImageLoadTask, reviewImageLoadTask].forEach { $0?.cancel() }
    }

    func setUpContents(review: Review, shouldSeeMore: Bool, screenWidth: CGFloat = 0) {
        self.review = review
        setUpTagCollectionViewContents()
        userNameLabel.setText(text: review.userNickname, font: .buttonLarge)
        writtenDateLabel.setText(text: review.writtenDate.toString(), font: .captionLarge)
        descriptionLabel.setText(text: review.description, font: .bodyMediumOverTwoLine)
        imageCountLabel.setText(text: "1 / \(review.imageURL.count)", font: .buttonSmall)
        imageCountLabel.isHidden = review.imageURL.count <= 1
        imageCountLabel.textAlignment = .center
        if review.profileImagePath.isEmpty {
            profileImageView.image = Asset.Images.avatar.image
        } else {
            profileImageLoadTask = profileImageView.kf.setImage(with: URL(string: review.profileImagePath))
        }
        reviewImageLoadTask = reviewImageView.kf.setImage(with: URL(string: review.imageURL.first ?? ""))
        remakeHeightConstraints()
        descriptionLabel.lineBreakMode = .byTruncatingTail
        if shouldSeeMore {
            descriptionLabel.numberOfLines = 0
        } else {
            descriptionLabel.numberOfLines = 3
        }
        let width = screenWidth == 0 ? contentView.frame.size.width : screenWidth
        let newSize = descriptionLabel.sizeThatFits(CGSize(width: width - 32,
                                         height: CGFloat.greatestFiniteMagnitude))
        descriptionLabel.snp.remakeConstraints {
            $0.height.equalTo(newSize.height).priority(.required)
        }
    }

    private func setUpTagCollectionViewContents() {
        guard let review = review else { return }
        tags = review.tags.filter { $0 != .noKeywordToChoose }
        tagCollectionView.reloadData()
        tagCollectionView.layoutIfNeeded()
    }

    private func layout() {
        [outerStackView, divisionLine].forEach {
            contentView.addSubview($0)
        }

        outerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(outerStackView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        [reviewInfoView, reviewImageOuterView, descriptionLabel, tagCollectionView].forEach {
            outerStackView.addArrangedSubview($0)
        }

        reviewInfoView.snp.makeConstraints {
            $0.height.equalTo(38).priority(.required)
        }

        outerStackView.setCustomSpacing(12, after: reviewInfoView)
        outerStackView.setCustomSpacing(18, after: reviewImageOuterView)
        outerStackView.setCustomSpacing(16, after: descriptionLabel)
    }

    private func remakeHeightConstraints() {
        guard let review = review else { return }

        if !review.imageURL.isEmpty {
            reviewImageOuterView.snp.remakeConstraints {
                $0.height.equalTo(168)
            }
            outerStackView.setCustomSpacing(12, after: reviewInfoView)
        } else {
            reviewImageOuterView.snp.remakeConstraints {
                $0.height.equalTo(0)
            }
            outerStackView.setCustomSpacing(0, after: reviewInfoView)
        }

        if !review.description.isEmpty {
            outerStackView.setCustomSpacing(18, after: reviewImageOuterView)
        } else {
            outerStackView.setCustomSpacing(0, after: reviewImageOuterView)
        }

        if let tags = tags, !tags.isEmpty {
            tagCollectionView.snp.remakeConstraints {
                $0.height.equalTo(22).priority(.high)
            }
            outerStackView.setCustomSpacing(16, after: descriptionLabel)
        } else {
            tagCollectionView.snp.remakeConstraints {
                $0.height.equalTo(0)
            }
            outerStackView.setCustomSpacing(0, after: descriptionLabel)
        }
    }

    @objc
    private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        photoImageTapped?()
    }

    @objc
    private func descriptionLabelTapped(_ sender: UITapGestureRecognizer) {
        if descriptionLabel.isTruncated {
            seeMoreTapped?()
        }
    }
}

// MARK: - tagCollectionView Layout
extension DetailReviewCell {
    private func tagCollectionLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .estimated(100), heightDimension: .estimated(22)),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
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
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR") ?? .current
        if let currentYear = Calendar.current.dateComponents([.year], from: Date()).year,
           let dateYear = Calendar.current.dateComponents([.year], from: Date()).year,
           currentYear == dateYear {
            dateFormatter.dateFormat = "M.d.EE"
        } else {
            dateFormatter.dateFormat = "yyyy.M.d"
        }

        return dateFormatter.string(from: self)
    }
}

fileprivate extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text, let font = font else { return false }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
