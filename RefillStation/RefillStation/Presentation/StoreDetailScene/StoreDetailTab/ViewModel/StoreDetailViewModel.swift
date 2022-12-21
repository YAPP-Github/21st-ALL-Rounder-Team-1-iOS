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

    let storeDetailInfoViewHeight: CGFloat = 300
    var mode: Mode = .reviews

    init() {
        detailReviewViewModel = DetailReviewViewModel()
        votedTagViewModel = VotedTagViewModel()
        storeDetailInfoViewModel = StoreDetailInfoViewModel()
        productListViewModel = ProductListViewModel()
    }

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
                return 1
            case .reviews:
                return Section.allCases.count
            }
        }
    }

    enum Section: Int, CaseIterable {
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
                return 240
            case .detailReviewCount:
                return 40
            case .detailReviews:
                return 280
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
