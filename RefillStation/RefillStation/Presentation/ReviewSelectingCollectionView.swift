//
//  ReviewSelectingCollectionView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class ReviewSelectingCollectionView: UICollectionView {

}

extension ReviewSelectingCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
