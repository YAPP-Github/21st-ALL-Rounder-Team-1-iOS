//
//  StoreReviewSection.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

extension StoreReviewViewController {

    enum Section: Int, CaseIterable {
        case moveToWriteReview
        case firstReviewRequest
        case votedCount
        case votedTag
        case detailReviewCount
        case detailReviews

        var estimatedCellHeight: CGFloat {
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
    }
}
