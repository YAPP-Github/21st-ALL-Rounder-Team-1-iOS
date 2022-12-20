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

    weak var tabViewDelegate: TabViewDelegate?

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
        detailReviewCollectionView.register(VotedTagCell.self,
                                            forCellWithReuseIdentifier: VotedTagCell.reuseIdentifier)

        detailReviewCollectionView.register(DetailReviewCountCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCountCell.reuseIdentifier)
        detailReviewCollectionView.register(DetailReviewCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCell.reuseIdentifier)

        detailReviewCollectionView.dataSource = self
        detailReviewCollectionView.delegate = self

        detailReviewCollectionView.allowsSelection = false

        detailReviewCollectionView.bounces = false
        detailReviewCollectionView.showsVerticalScrollIndicator = false
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
        case Section.votedCount.rawValue:
            return votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case Section.votedTag.rawValue:
            return votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case Section.detailReviewCount.rawValue:
            return detailReviewViewModel.detailReviews.count == 0 ? 0 : 1
        case Section.detailReviews.rawValue:
            return detailReviewViewModel.detailReviews.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.moveToWriteReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier,
                for: indexPath) as? MoveToWriteReviewCell else { return UICollectionViewCell() }
            cell.moveToWriteReview = { [weak self] in
                self?.navigationController?.pushViewController(ReviewWritingViewController(),
                                                               animated: true)
            }
            return cell
        case Section.votedCount.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VotedCountLabelCell.reuseIdentifier,
                for: indexPath) as? VotedCountLabelCell else { return UICollectionViewCell() }
            cell.setUpContents(totalVote: votedTagViewModel.totalVoteCount)
            return cell
        case Section.votedTag.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VotedTagCell.reuseIdentifier,
                for: indexPath) as? VotedTagCell else { return UICollectionViewCell() }
            cell.setUpContents(tagReviews: votedTagViewModel.tagReviews)
            return cell
        case Section.detailReviewCount.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailReviewCountCell.reuseIdentifier,
                for: indexPath) as? DetailReviewCountCell else { return UICollectionViewCell() }
            cell.setUpContents(totalDetailReviewCount: detailReviewViewModel.detailReviews.count)
            return cell
        case Section.detailReviews.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailReviewCell.reuseIdentifier,
                for: indexPath) as? DetailReviewCell else { return UICollectionViewCell() }
            cell.setUpContents(detailReview: detailReviewViewModel.detailReviews[indexPath.row])

            cell.setUpSeeMore(
                isSeeMoreButtonAlreadyTapped: detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
            )

            cell.reloadCell = {
                if self.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath) {
                    self.detailReviewViewModel.seeMoreTappedIndexPaths.remove(
                        at: self.detailReviewViewModel.seeMoreTappedIndexPaths.firstIndex(of: indexPath)!
                    )
                } else {
                    self.detailReviewViewModel.seeMoreTappedIndexPaths.append(indexPath)
                }
                self.detailReviewCollectionView.reloadItems(at: [indexPath])
            }

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
        let width = collectionView.frame.width - 2 * Constraints.outerCollectionViewInset
        guard let height = Section(rawValue: indexPath.section)?.estimatedCellHeight else { return .zero }

        if Section(rawValue: indexPath.section) == .detailReviews {
            let dummyCellForCalculateheight = DetailReviewCell(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                      size: CGSize(width: width, height: height)))
            dummyCellForCalculateheight.setUpContents(detailReview: detailReviewViewModel.detailReviews[indexPath.row])
            dummyCellForCalculateheight.setUpSeeMore(
                isSeeMoreButtonAlreadyTapped: self.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
            )
            let heightThatFits = dummyCellForCalculateheight.systemLayoutSizeFitting(CGSize(width: width, height: height)).height
            return CGSize(width: width, height: heightThatFits)
        }

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = Constraints.outerCollectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}

// MARK: - Constraints

extension StoreReviewViewController {

    enum Constraints {
        static let outerCollectionViewInset: CGFloat = 16
    }
}

// MARK: - UIScrollViewDelegate

extension StoreReviewViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabViewDelegate?.scrollViewDidScroll(offset: scrollView.contentOffset)
    }
}
