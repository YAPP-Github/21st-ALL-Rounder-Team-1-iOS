//
//  OperationInfoViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/08.
//

import Foundation

final class OperationInfoViewModel {
    var operationInfos = MockEntityData.operations()

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
