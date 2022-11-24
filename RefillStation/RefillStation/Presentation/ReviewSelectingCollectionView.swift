//
//  ReviewSelectingCollectionView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class ReviewSelectingCollectionView: UICollectionView {

    var viewModel: ReviewSelectingViewModel

    init(viewModel: ReviewSelectingViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionViewLayout = compositionalLayout()
        dataSource = self
        delegate = self
        allowsMultipleSelection = true
        register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1/4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(7/10),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewSelectingCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TagCollectionViewCell.reuseIdentifier,
            for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }

        cell.setUpContents(title: viewModel.reviews[indexPath.row].tagTitle)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ReviewSelectingCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let selectedCount = collectionView.indexPathsForSelectedItems?.count else {
            return false
        }

        return selectedCount < 3
    }
}
