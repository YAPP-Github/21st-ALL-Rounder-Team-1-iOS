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
        detailReviewCollectionView.register(FirstReviewRequestCell.self,
                                            forCellWithReuseIdentifier: FirstReviewRequestCell.reuseIdentifier)
        detailReviewCollectionView.register(MoveToWriteReviewCell.self,
                                            forCellWithReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier)
        detailReviewCollectionView.register(VotedCountLabelCell.self,
                                            forCellWithReuseIdentifier: VotedCountLabelCell.reuseIdentifier)
        detailReviewCollectionView.register(DetailReviewCollectionViewCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCollectionViewCell.reuseIdentifier)
        detailReviewCollectionView.register(VotedTagCollectionViewCell.self,
                                            forCellWithReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier)
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
        case Section.DetailReviewCollectionView.rawValue:
            return detailReviewViewModel.detailReviews.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.firstReviewRequest.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FirstReviewRequestCell.reuseIdentifier,
                for: indexPath) as? FirstReviewRequestCell else { return UICollectionViewCell() }
            return cell
        case Section.moveToWriteReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier,
                for: indexPath) as? MoveToWriteReviewCell else { return UICollectionViewCell() }
            return cell
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
        case Section.DetailReviewCollectionView.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailReviewCollectionViewCell.reuseIdentifier,
                for: indexPath) as? DetailReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(detailReview: detailReviewViewModel.detailReviews[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StoreReviewViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * Constraints.outerCollectionViewInset // inset 좌 우 각각 20

        switch indexPath.section {
        case Section.firstReviewRequest.rawValue:
            return CGSize(width: width, height: Constraints.firstReviewRequestHeight)
        case Section.moveToWriteReview.rawValue:
            return CGSize(width: width, height: Constraints.moveToWriteReviewHeight)
        case Section.VotedCountLabel.rawValue:
            return CGSize(width: width, height: Constraints.votedCountLabelHeight)
        case Section.VotedTagCollectionView.rawValue:
            return CGSize(width: width, height: Constraints.votedCollectionViewCellHeight)
        case Section.DetailReviewCollectionView.rawValue:
            return CGSize(width: width, height: Constraints.detailReviewCellHeight)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = Constraints.outerCollectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

// MARK: - Section

extension StoreReviewViewController {

    enum Section: Int, CaseIterable {
        case moveToWriteReview
        case firstReviewRequest
        case VotedCountLabel
        case VotedTagCollectionView
        case DetailReviewCollectionView
    }
}

// MARK: - Constraints

extension StoreReviewViewController {

    enum Constraints {
        static let moveToWriteReviewHeight: CGFloat = 40
        static let firstReviewRequestHeight: CGFloat = 190
        static let votedCountLabelHeight: CGFloat = 40
        static let votedCollectionViewCellHeight: CGFloat = 240
        static let detailReviewCellHeight: CGFloat = 200
        static let outerCollectionViewInset: CGFloat = 10
    }
}
