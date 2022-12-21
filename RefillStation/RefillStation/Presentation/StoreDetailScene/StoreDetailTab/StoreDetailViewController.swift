//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController {

    private let viewModel: StoreDetailViewModel

    private lazy var storeDetailInfoView = StoreDetailInfoView(viewModel: viewModel.storeDetailInfoViewModel)

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    init(viewModel: StoreDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        viewModel = StoreDetailViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        layout()
    }

    private func setUpCollectionView() {
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.reuseIdentifier
        )

        StoreDetailViewModel.Section.allCases.forEach {
            self.collectionView.register(
                $0.cell,
                forCellWithReuseIdentifier: $0.reuseIdentifier
            )
        }

        collectionView.register(
            StoreDetailHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StoreDetailHeaderView.reuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.allowsSelection = false

        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false

        collectionView.contentInset = UIEdgeInsets(
            top: viewModel.storeDetailInfoViewHeight, left: 0, bottom: 0, right: 0
        )
    }

    private func layout() {
        [collectionView, storeDetailInfoView].forEach { view.addSubview($0) }
        view.addSubview(collectionView)
        view.addSubview(storeDetailInfoView)

        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        storeDetailInfoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(viewModel.storeDetailInfoViewHeight)
        }
    }
}

extension StoreDetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.mode.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.mode == .productLists {
            return viewModel.productListViewModel.products.count
        }

        switch section {
        case StoreDetailViewModel.Section.moveToWriteReview.rawValue:
            return 1
        case StoreDetailViewModel.Section.firstReviewRequest.rawValue:
            return viewModel.votedTagViewModel.totalVoteCount
            + viewModel.detailReviewViewModel.detailReviews.count == 0 ? 1 : 0
        case StoreDetailViewModel.Section.votedCount.rawValue:
            return viewModel.votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case StoreDetailViewModel.Section.votedTag.rawValue:
            return viewModel.votedTagViewModel.totalVoteCount == 0 ? 0 : 1
        case StoreDetailViewModel.Section.detailReviewCount.rawValue:
            return viewModel.detailReviewViewModel.detailReviews.count == 0 ? 0 : 1
        case StoreDetailViewModel.Section.detailReviews.rawValue:
            return viewModel.detailReviewViewModel.detailReviews.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.mode == .productLists,
           let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.reuseIdentifier,
            for: indexPath) as? ProductCell {
            cell.setUpContents(product: viewModel.productListViewModel.products[indexPath.row])
            return cell
        }

        guard let reuseIdentifier = StoreDetailViewModel.Section(rawValue: indexPath.section)?.reuseIdentifier else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        if let cell = cell as? MoveToWriteReviewCell {
            cell.moveToWriteReview = { [weak self] in
                self?.navigationController?.pushViewController(
                    ReviewWritingViewController(),
                    animated: true
                )
            }
            return cell
        }

        if let cell = cell as? VotedCountLabelCell {
            cell.setUpContents(totalVote: viewModel.votedTagViewModel.totalVoteCount)
            return cell
        }

        if let cell = cell as? VotedTagCell {
            cell.setUpContents(tagReviews: viewModel.votedTagViewModel.tagReviews)
            return cell
        }

        if let cell = cell as? DetailReviewCountCell {
            cell.setUpContents(totalDetailReviewCount: viewModel.detailReviewViewModel.detailReviews.count)
            return cell
        }

        if let cell = cell as? DetailReviewCell {
            cell.setUpContents(detailReview: viewModel.detailReviewViewModel.detailReviews[indexPath.row])

            cell.setUpSeeMore(
                isSeeMoreButtonAlreadyTapped: viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
            )

            cell.reloadCell = {
                if self.viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath),
                let indexPathToRemove = self.viewModel.detailReviewViewModel
                    .seeMoreTappedIndexPaths.firstIndex(of: indexPath) {
                    self.viewModel.detailReviewViewModel
                        .seeMoreTappedIndexPaths.remove(at: indexPathToRemove)
                } else {
                    self.viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.append(indexPath)
                }
                self.collectionView.reloadItems(at: [indexPath])
            }
            return cell
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StoreDetailHeaderView.reuseIdentifier,
            for: indexPath)

        return header
    }
}

extension StoreDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * Constraints.outerCollectionViewInset
        guard let height = StoreDetailViewModel.Section(rawValue: indexPath.section)?.cellHeight else { return .zero }

        if viewModel.mode == .productLists {
            let dummyCellForCalculateheight = ProductCell(frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: width, height: height))
            )
            dummyCellForCalculateheight.setUpContents(
                product: viewModel.productListViewModel.products[indexPath.row]
            )
            let heightThatFits = dummyCellForCalculateheight.systemLayoutSizeFitting(CGSize(width: width, height: height)).height
            return CGSize(width: width, height: heightThatFits)
        }

        if StoreDetailViewModel.Section(rawValue: indexPath.section) == .detailReviews {
            let dummyCellForCalculateheight = DetailReviewCell(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                                             size: CGSize(width: width, height: height)))
            dummyCellForCalculateheight.setUpContents(detailReview: viewModel.detailReviewViewModel.detailReviews[indexPath.row])
            dummyCellForCalculateheight.setUpSeeMore(
                isSeeMoreButtonAlreadyTapped: self.viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard section == 0 else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension StoreDetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let storeInfoViewY = view.safeAreaLayoutGuide.layoutFrame.minY
        - scrollView.contentOffset.y
        - viewModel.storeDetailInfoViewHeight

        storeDetailInfoView.frame = CGRect(
            origin: CGPoint(x: 0, y: storeInfoViewY),
            size: storeDetailInfoView.frame.size
        )
    }
}

extension StoreDetailViewController {

    enum Constraints {
        static let outerCollectionViewInset: CGFloat = 16
    }
}
