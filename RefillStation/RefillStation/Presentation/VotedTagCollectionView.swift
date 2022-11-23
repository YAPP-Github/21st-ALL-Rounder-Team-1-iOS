//
//  VotedTagCollectionView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class VotedTagCollectionView: UICollectionView {

    let viewModel = VotedTagCollectionViewModel()

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - UICollectionViewDataSource

extension VotedTagCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tagReviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VotedTagCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width * 0.8
        let height: CGFloat = 15
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate

extension VotedTagCollectionView: UICollectionViewDelegate {

}
