//
//  StoreReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreReviewViewController: UIViewController {

    private var detailReviewViewModel = DetailReviewViewModel()
    private var votedTagViewModel = VotedTagViewModel()

    private lazy var detailReviewCollectionView = UICollectionView(frame: .zero,
                                                                   collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeMockViewModel()
        setUpDetailReviewCollectionView()
        layout()
        detailReviewCollectionView.reloadData()
    }

    private func setUpDetailReviewCollectionView() {
        detailReviewCollectionView.register(MoveToWriteReviewCell.self,
                                            forCellWithReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier)
        detailReviewCollectionView.register(DetailReviewCollectionViewCell.self,
                                            forCellWithReuseIdentifier: DetailReviewCollectionViewCell.reuseIdentifier)
        detailReviewCollectionView.register(VotedTagCollectionViewCell.self,
                                            forCellWithReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier)
        detailReviewCollectionView.register(VotedTagCollectionHeader.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: VotedTagCollectionHeader.reuseIdentifier)
        detailReviewCollectionView.dataSource = self
        detailReviewCollectionView.delegate = self
        detailReviewCollectionView.allowsSelection = false
    }

    private func makeMockViewModel() {
        detailReviewViewModel.detailReviews = [
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description")
        ]
        votedTagViewModel.totalVoteCount = 10
        votedTagViewModel.tagReviews = [
            .init(tagTitle: "친절해요", voteCount: 3),
            .init(tagTitle: "청결해요", voteCount: 4),
            .init(tagTitle: "배고파요", voteCount: 5),
            .init(tagTitle: "살려줘요", voteCount: 6)
        ]
    }

    private func layout() {
        view.addSubview(detailReviewCollectionView)

        detailReviewCollectionView.snp.makeConstraints { collection in
            collection.leading.trailing.bottom.equalTo(view).inset(10)
            collection.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension StoreReviewViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return votedTagViewModel.tagReviews.count
        case 2:
            return detailReviewViewModel.detailReviews.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoveToWriteReviewCell.reuseIdentifier,
                for: indexPath) as? MoveToWriteReviewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VotedTagCollectionViewCell.reuseIdentifier,
                for: indexPath) as? VotedTagCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(tagReview: votedTagViewModel.tagReviews[indexPath.row],
                             totalVoteCount: votedTagViewModel.totalVoteCount)
            return cell
        case 2:
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

extension StoreReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20 // inset 좌 우 각각 20

        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 40)
        case 1:
            return CGSize(width: width, height: 30)
        case 2:
            return CGSize(width: width, height: 200)
        default:
            return CGSize()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
