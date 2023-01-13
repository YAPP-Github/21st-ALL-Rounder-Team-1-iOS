//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewModel {
    let detailReviewViewModel: DetailReviewViewModel
    let votedTagViewModel: VotedTagViewModel
    let storeDetailInfoViewModel: StoreDetailInfoViewModel
    let productListViewModel: ProductListViewModel
    let operationInfoViewModel: OperationInfoViewModel

    let storeDetailInfoViewHeight: CGFloat = 400
    var mode: Mode = .productLists

    var withoutReviewCount: Int {
        if votedTagViewModel.totalVoteCount == 0 {
            return 1
        } else {
            return 4
        }
    }

    var reloadItemsAt: (([IndexPath]) -> Void)? {
        didSet {
            productListViewModel.reloadItemsAt = { [weak self] indexPaths in
                self?.reloadItemsAt?(indexPaths)
            }
        }
    }

    func productListSection(for indexPath: IndexPath) -> ProductListSection {
        if indexPath.row == 0 {
            return ProductListSection.productCategory
        } else if indexPath.row == 1 {
            return ProductListSection.productsCount
        } else {
            return ProductListSection.productList
        }
    }

    func reviewListSection(for indexPath: IndexPath) -> ReviewSection {
        if votedTagViewModel.totalVoteCount == 0 {
            return ReviewSection.moveToWriteReview
        } else if indexPath.row == 0 {
            return ReviewSection.moveToWriteReview
        } else if indexPath.row == 1 {
            return ReviewSection.votedCount
        } else if indexPath.row == 2 {
            return ReviewSection.votedTag
        } else if indexPath.row == 3 {
            return ReviewSection.detailReviewCount
        } else {
            return ReviewSection.detailReviews
        }
    }

    init(
        detailReviewViewModel: DetailReviewViewModel,
        votedTagViewModel: VotedTagViewModel,
        storeDetailInfoViewModel: StoreDetailInfoViewModel,
        productListViewModel: ProductListViewModel,
        operationInfoViewModel: OperationInfoViewModel
    ) {
        self.detailReviewViewModel = detailReviewViewModel
        self.votedTagViewModel = votedTagViewModel
        self.storeDetailInfoViewModel = storeDetailInfoViewModel
        self.productListViewModel = productListViewModel
        self.operationInfoViewModel = operationInfoViewModel
    }
}

extension StoreDetailViewModel {
    enum Mode {
        case productLists
        case reviews
        case operationInfo

        var name: String {
            switch self {
            case .productLists:
                return "판매상품"
            case .reviews:
                return "리뷰"
            case .operationInfo:
                return "운영정보"
            }
        }
    }

    enum StoreInfoSection {
        case main

        var section: NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(400))
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(400)), subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }

    enum ProductListSection: Int, CaseIterable {
        case productCategory
        case productsCount
        case productList

        var cellHeight: CGFloat {
            return 113
        }

        var reuseIdentifier: String {
            switch self {
            case .productCategory:
                return ProductCategoriesCell.reuseIdentifier
            case .productsCount:
                return ProductListHeaderCell.reuseIdentifier
            case .productList:
                return ProductCell.reuseIdentifier
            }
        }

        var cell: UICollectionViewCell.Type {
            switch self {
            case .productCategory:
                return ProductCategoriesCell.self
            case .productsCount:
                return ProductListHeaderCell.self
            case .productList:
                return ProductCell.self
            }
        }

        var section: NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(cellHeight)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(cellHeight)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }

    enum ReviewSection: Int, CaseIterable {
        case moveToWriteReview = 1
        case firstReviewRequest = 2
        case votedCount = 3
        case votedTag = 4
        case detailReviewCount = 5
        case detailReviews = 6

        var cellHeight: CGFloat {
            return 600
        }

        var reuseIdentifier: String {
            switch self {
            case .moveToWriteReview:
                return MoveToWriteReviewCell.reuseIdentifier
            case .firstReviewRequest:
                return FirstReviewRequestCell.reuseIdentifier
            case .votedCount:
                return VotedCountLabelCell.reuseIdentifier
            case .votedTag:
                return VotedTagCell.reuseIdentifier
            case .detailReviewCount:
                return DetailReviewCountCell.reuseIdentifier
            case .detailReviews:
                return DetailReviewCell.reuseIdentifier
            }
        }

        var cell: UICollectionViewCell.Type {
            switch self {
            case .moveToWriteReview:
                return MoveToWriteReviewCell.self
            case .firstReviewRequest:
                return FirstReviewRequestCell.self
            case .votedCount:
                return VotedCountLabelCell.self
            case .votedTag:
                return VotedTagCell.self
            case .detailReviewCount:
                return DetailReviewCountCell.self
            case .detailReviews:
                return DetailReviewCell.self
            }
        }

        var section: NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(cellHeight)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(cellHeight)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }

    enum OperationInfoSection {
        case main

        var section: NSCollectionLayoutSection {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }
}
