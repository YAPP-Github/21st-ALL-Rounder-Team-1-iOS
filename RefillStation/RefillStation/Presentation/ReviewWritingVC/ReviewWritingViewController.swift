//
//  ReviewWritingViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewWritingViewController: UIViewController {

    private var reviewSelectingViewModel = TagReviewViewModel()

    private lazy var outerCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: compositionalLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeMockViewModel()
        setUpCollectionView()
        layout()
    }

    private func makeMockViewModel() {
        reviewSelectingViewModel.reviews = [
            .init(tagTitle: "점원이 친절해요", voteCount: 0),
            .init(tagTitle: "품목이 다양해요", voteCount: 0),
            .init(tagTitle: "매장이 청결해요", voteCount: 0),
            .init(tagTitle: "사장님이 맛있어요", voteCount: 0),
            .init(tagTitle: "음식이 친절해요", voteCount: 0),
            .init(tagTitle: "개발자가 죽어가요", voteCount: 0),
            .init(tagTitle: "일정이 빡빡해요", voteCount: 0),
            .init(tagTitle: "도움이 필요해요", voteCount: 0)
        ]
    }

    private func setUpCollectionView() {
        outerCollectionView.register(StoreInfoCell.self,
                                     forCellWithReuseIdentifier: StoreInfoCell.reuseIdentifier)
        outerCollectionView.register(VoteTitleCell.self,
                                     forCellWithReuseIdentifier: VoteTitleCell.reuseIdentifier)
        outerCollectionView.register(TagReviewCell.self,
                                     forCellWithReuseIdentifier: TagReviewCell.reuseIdentifier)
        outerCollectionView.register(ReviewPhotosCell.self,
                                forCellWithReuseIdentifier: ReviewPhotosCell.reuseIdentifier)
        outerCollectionView.register(ReviewDescriptionCell.self,
                                forCellWithReuseIdentifier: ReviewDescriptionCell.reuseIdentifier)
        outerCollectionView.dataSource = self
    }

    private func layout() {
        view.addSubview(outerCollectionView)

        outerCollectionView.snp.makeConstraints { collection in
            collection.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewWritingViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.tagReview.rawValue:
            return reviewSelectingViewModel.reviews.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.storeInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoreInfoCell.reuseIdentifier,
                for: indexPath) as? StoreInfoCell else { return UICollectionViewCell() }
            cell.setUpContents(storeName: "가게이름", storeLocationInfo: "가게위치")
            return cell
        case Section.voteTitle.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VoteTitleCell.reuseIdentifier,
                for: indexPath) as? VoteTitleCell else { return UICollectionViewCell() }
            return cell
        case Section.tagReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TagReviewCell.reuseIdentifier,
                for: indexPath) as? TagReviewCell else { return UICollectionViewCell() }
            cell.setUpContents(title: reviewSelectingViewModel.reviews[indexPath.row].tagTitle)
            return cell
        case Section.photoReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewPhotosCell.reuseIdentifier,
                for: indexPath) as? ReviewPhotosCell else { return UICollectionViewCell() }
            return cell
        case Section.reviewDescription.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewDescriptionCell.reuseIdentifier,
                for: indexPath) as? ReviewDescriptionCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewCompositionalLayout
extension ReviewWritingViewController {
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
            return Section(rawValue: section)?.layoutSection
        }
    }
}

// MARK: - Section

extension ReviewWritingViewController {
    enum Section: Int, CaseIterable {
        case storeInfo
        case voteTitle
        case tagReview
        case photoReview
        case reviewDescription

        var layoutSection: NSCollectionLayoutSection {
            let defaultItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let defaultItem = NSCollectionLayoutItem(layoutSize: defaultItemSize)
            defaultItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            var section: NSCollectionLayoutSection

            switch self {
            case .storeInfo:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .voteTitle:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .tagReview:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1/4))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(7/10),
                                                       heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
            case .photoReview:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .reviewDescription:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(400))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            }

            return section
        }
    }
}
