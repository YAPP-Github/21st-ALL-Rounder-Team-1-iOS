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
        case votedTagBoxes
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
            case .votedTagBoxes:
                return 240
            case .detailReviewCount:
                return 40
            case .detailReviews:
                return 200
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
            case .votedTagBoxes:
                return VotedTagCollectionViewCell.reuseIdentifier
            case .detailReviewCount:
                return DetailReviewCountCell.reuseIdentifier
            case .detailReviews:
                return DetailReviewCollectionViewCell.reuseIdentifier
            }
        }
    }
}
