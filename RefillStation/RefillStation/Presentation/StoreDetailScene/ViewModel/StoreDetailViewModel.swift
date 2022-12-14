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

    let storeDetailInfoViewHeight: CGFloat = 400
    var mode: Mode = .productLists

    init(
        detailReviewViewModel: DetailReviewViewModel,
        votedTagViewModel: VotedTagViewModel,
        storeDetailInfoViewModel: StoreDetailInfoViewModel,
        productListViewModel: ProductListViewModel
    ) {
        self.detailReviewViewModel = detailReviewViewModel
        self.votedTagViewModel = votedTagViewModel
        self.storeDetailInfoViewModel = storeDetailInfoViewModel
        self.productListViewModel = productListViewModel
    }
}

extension StoreDetailViewModel {
    enum Mode {
        case productLists
        case reviews

        var name: String {
            switch self {
            case .productLists:
                return "판매상품"
            case .reviews:
                return "리뷰"
            }
        }

        var sectionCount: Int {
            switch self {
            case .productLists:
                return ProductListSection.allCases.count
            case .reviews:
                return ReviewSection.allCases.count
            }
        }
    }

    enum ProductListSection: Int, CaseIterable {
        case productCategory
        case productsCount
        case productList

        var cellHeight: CGFloat {
            switch self {
            case .productCategory:
                return 35
            case .productsCount:
                return 30
            case .productList:
                return 125
            }
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
    }

    enum ReviewSection: Int, CaseIterable {
        case moveToWriteReview
        case firstReviewRequest
        case votedCount
        case votedTag
        case detailReviewCount
        case detailReviews

        var cellHeight: CGFloat {
            switch self {
            case .moveToWriteReview:
                return 40
            case .firstReviewRequest:
                return 190
            case .votedCount:
                return 40
            case .votedTag:
                return 300
            case .detailReviewCount:
                return 40
            case .detailReviews:
                return 400
            }
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
    }
}
