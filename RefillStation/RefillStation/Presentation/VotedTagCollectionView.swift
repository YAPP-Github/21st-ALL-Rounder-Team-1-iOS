//
//  VotedTagCollectionView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class VotedTagCollectionView: UICollectionView {

    let viewModel: VotedTagViewModel

    init(viewModel: VotedTagViewModel) {
        self.viewModel = viewModel
        let flowLayout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        register(VotedTagCollectionViewCell.self,
                 forCellWithReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier)
        register(VotedTagCollectionHeader.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: VotedTagCollectionHeader.reuseIdentifier)
        dataSource = self
        delegate = self
        isScrollEnabled = false
    }

    required init?(coder: NSCoder) {
        self.viewModel = VotedTagViewModel()
        super.init(coder: coder)
    }
}

// MARK: - UICollectionViewDataSource

extension VotedTagCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tagReviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier,
            for: indexPath) as? VotedTagCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setContents(tagReview: viewModel.tagReviews[indexPath.row], totalVoteCount: viewModel.totalVoteCount)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VotedTagCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 25
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate

extension VotedTagCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: VotedTagCollectionHeader.reuseIdentifier,
            for: indexPath) as? VotedTagCollectionHeader else { return UICollectionReusableView() }

        header.setUpContents(totalVote: viewModel.totalVoteCount)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
