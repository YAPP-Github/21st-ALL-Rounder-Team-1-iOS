//
//  ReviewWritingViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewWritingViewController: UIViewController {

    private var reviewSelectingViewModel = ReviewSelectingViewModel()

    private let outerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeMockViewModel()
        setUpCollectionView()
        layout()
    }

    private func makeMockViewModel() {
        reviewSelectingViewModel.reviews = [
            .init(tagTitle: "점원이 친절해요", voteCount: 0),
            .init(tagTitle: "품목이 다양해요", voteCount: 0),
            .init(tagTitle: "매장이 청결해요", voteCount: 0),
            .init(tagTitle: "사장님이 맛있어요", voteCount: 0),
            .init(tagTitle: "음식이 친절해요", voteCount: 0),
            .init(tagTitle: "개발자가 죽어가요", voteCount: 0),
            .init(tagTitle: "일정이 빡빡해요", voteCount: 0),
            .init(tagTitle: "도움이 필요해요", voteCount: 0)
        ]
    }

    private func setUpCollectionView() {
        outerCollectionView.register(TagCollectionViewCell.self,
                                forCellWithReuseIdentifier: TagReviewCell.reuseIdentifier)
        outerCollectionView.register(ReviewPhotosCell.self,
                                forCellWithReuseIdentifier: ReviewPhotosCell.reuseIdentifier)
        outerCollectionView.register(ReviewDescriptionCell.self,
                                forCellWithReuseIdentifier: ReviewDescriptionCell.reuseIdentifier)
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
    }

    private func layout() {
        view.addSubview(outerCollectionView)

        outerCollectionView.snp.makeConstraints { collection in
            collection.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewWritingViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.storeInfo.rawValue:
            return 1
        case Section.voteTitle.rawValue:
            return 1
        case Section.tagReview.rawValue:
            break
        case Section.photoReview.rawValue:
            break
        case Section.reviewDescription.rawValue:
            break
        default:
            break
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.storeInfo.rawValue:
            break
        case Section.voteTitle.rawValue:
            break
        case Section.tagReview.rawValue:
            break
        case Section.photoReview.rawValue:
            break
        case Section.reviewDescription.rawValue:
            break
        default:
            break
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewWritingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case Section.storeInfo.rawValue:
            break
        case Section.voteTitle.rawValue:
            break
        case Section.tagReview.rawValue:
            break
        case Section.photoReview.rawValue:
            break
        case Section.reviewDescription.rawValue:
            break
        default:
            break
        }
        return CGSize()
    }
}

// MARK: - Section

extension ReviewWritingViewController {
    enum Section: Int, CaseIterable {
        case storeInfo
        case voteTitle
        case tagReview
        case photoReview
        case reviewDescription
    }
}
