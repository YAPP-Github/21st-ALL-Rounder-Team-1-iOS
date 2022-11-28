//
//  StoreReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreReviewViewController: UIViewController {

    private lazy var detailReviewViewModel = makeMockDetailReviewViewModel()
    private lazy var votedTagViewModel = makeMockVoteTagViewModel()

    private lazy var detailReviewCollectionView = UICollectionView(frame: .zero,
                                                                   collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpDetailReviewCollectionView()
        layout()
    }

    private func setUpDetailReviewCollectionView() {
        detailReviewCollectionView.register(MoveToWriteReviewCell.self,
                                            forCellWithReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier)
        detailReviewCollectionView.register(FirstReviewRequestCell.self,
                                            forCellWithReuseIdentifier: FirstReviewRequestCell.reuseIdentifier)

        detailReviewCollectionView.register(VotedCountLabelCell.self,
                                            forCellWithReuseIdentifier: VotedCountLabelCell.reuseIdentifier)
        detailReviewCollectionView.register(VotedTagCollectionViewCell.self,
                                            forCellWithReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier)

        detailReviewCollectionView.register(DetailReviewCountCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCountCell.reuseIdentifier)
        detailReviewCollectionView.register(DetailReviewCollectionViewCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCollectionViewCell.reuseIdentifier)

        detailReviewCollectionView.dataSource = self
        detailReviewCollectionView.delegate = self
        detailReviewCollectionView.allowsSelection = false
    }

    private func layout() {
        view.addSubview(detailReviewCollectionView)

        detailReviewCollectionView.snp.makeConstraints { collection in
            collection.leading.trailing.bottom.equalTo(view)
            collection.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension StoreReviewViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.moveToWriteReview.rawValue:
            return 1
        case Section.firstReviewRequest.rawValue:
            return votedTagViewModel.totalVoteCount + detailReviewViewModel.detailReviews.count == 0 ? 1 : 0
        case Section.VotedCountLabel.rawValue:
            return votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case Section.VotedTagCollectionView.rawValue:
            return votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case Section.detailReviewCount.rawValue:
            return detailReviewViewModel.detailReviews.count == 0 ? 0 : 1
        case Section.DetailReviewCollectionView.rawValue:
            return detailReviewViewModel.detailReviews.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.VotedCountLabel.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VotedCountLabelCell.reuseIdentifier,
                for: indexPath) as? VotedCountLabelCell else { return UICollectionViewCell() }
            cell.setUpContents(totalVote: votedTagViewModel.totalVoteCount)
            return cell
        case Section.VotedTagCollectionView.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier,
                for: indexPath) as? VotedTagCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(tagReviews: votedTagViewModel.tagReviews)
            return cell
        case Section.detailReviewCount.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailReviewCountCell.reuseIdentifier,
                for: indexPath) as? DetailReviewCountCell else { return UICollectionViewCell() }
            cell.setUpContents(totalDetailReviewCount: detailReviewViewModel.detailReviews.count)
            return cell
        case Section.DetailReviewCollectionView.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailReviewCollectionViewCell.reuseIdentifier,
                for: indexPath) as? DetailReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(detailReview: detailReviewViewModel.detailReviews[indexPath.row])
            return cell
        default:
            guard let reuseIdentifier = Section(rawValue: indexPath.section)?.reuseIdentifier else {
                return UICollectionViewCell()
            }
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StoreReviewViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * Constraints.outerCollectionViewInset // inset 좌 우 각각 20
        guard let height = Section(rawValue: indexPath.section)?.cellHeight else { return .zero }
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = Constraints.outerCollectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

// MARK: - Constraints

extension StoreReviewViewController {

    enum Constraints {
        static let outerCollectionViewInset: CGFloat = 10
    }
}
