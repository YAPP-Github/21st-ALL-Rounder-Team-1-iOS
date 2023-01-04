//
//  DefaultTagReviewViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol TagReviewViewModelInput {
}

protocol TagReviewViewModelOutput {
}

protocol TagReviewViewModel: TagReviewViewModelInput, TagReviewViewModelOutput { }

final class DefaultTagReviewViewModel: TagReviewViewModel {

    var disposeBag = DisposeBag()
    var tags = MockEntityData.tags()
    var indexPathsForSelectedItems = [IndexPath]()
    var shouldSelectCell: Bool {
        return indexPathsForSelectedItems.count < 3
    }

    func didSelectItemAt(indexPath: IndexPath) {
        indexPathsForSelectedItems.append(indexPath)
    }

    func didDeselectItemAt(indexPath: IndexPath) {
        if let indexPathToRemove = indexPathsForSelectedItems.firstIndex(of: indexPath) {
            indexPathsForSelectedItems.remove(at: indexPathToRemove)
        }
    }
}
