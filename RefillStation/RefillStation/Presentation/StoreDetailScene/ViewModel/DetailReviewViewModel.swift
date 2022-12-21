//
//  DetailReviewViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import Foundation

final class DetailReviewViewModel {

    var detailReviews = [DetailReview]()
    var seeMoreTappedIndexPaths = [IndexPath]()

    func seeMoreDidTapped(indexPath: IndexPath) {
        if seeMoreTappedIndexPaths.contains(indexPath),
           let indexPathToRemove = seeMoreTappedIndexPaths.firstIndex(of: indexPath) {
            seeMoreTappedIndexPaths.remove(at: indexPathToRemove)
        } else {
            seeMoreTappedIndexPaths.append(indexPath)
        }
    }
}
