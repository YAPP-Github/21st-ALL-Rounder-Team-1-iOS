//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController {

    private var viewModel: StoreDetailViewModel!

    private lazy var storeDetailInfoView = StoreDetailInfoView(
        viewModel: viewModel.storeDetailInfoViewModel,
        storeDetailInfoStackViewDelegate: self)

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let imageConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24))
        let image = UIImage(systemName: "chevron.backward", withConfiguration: imageConfiguration)
        button.setImage(image, for: .normal)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        return button
    }()

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
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpCollectionView()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = ""
    }

    private func setUpCollectionView() {
        StoreDetailViewModel.ProductListSection.allCases.forEach {
            self.collectionView.register(
                $0.cell,
                forCellWithReuseIdentifier: $0.reuseIdentifier
            )
        }

        StoreDetailViewModel.ReviewSection.allCases.forEach {
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

        collectionView.showsVerticalScrollIndicator = false

        collectionView.contentInset = UIEdgeInsets(
            top: viewModel.storeDetailInfoViewHeight, left: 0, bottom: 0, right: 0
        )
    }

    private func layout() {
        [collectionView, storeDetailInfoView, backButton].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view)
            $0.top.equalTo(view)
        }

        storeDetailInfoView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(viewModel.storeDetailInfoViewHeight)
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}

extension StoreDetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.mode.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.mode == .productLists {
            switch section {
            case StoreDetailViewModel.ProductListSection.productList.rawValue:
                return viewModel.productListViewModel.filteredProducts.count
            default:
                return 1
            }
        } else {
            switch section {
            case StoreDetailViewModel.ReviewSection.moveToWriteReview.rawValue:
                return 1
            case StoreDetailViewModel.ReviewSection.firstReviewRequest.rawValue:
                return viewModel.votedTagViewModel.totalVoteCount
                + viewModel.detailReviewViewModel.detailReviews.count == 0 ? 1 : 0
            case StoreDetailViewModel.ReviewSection.votedCount.rawValue:
                return viewModel.votedTagViewModel.totalVoteCount == 0 ? 0 : 1
            case StoreDetailViewModel.ReviewSection.votedTag.rawValue:
                return viewModel.votedTagViewModel.totalVoteCount == 0 ? 0 : 1
            case StoreDetailViewModel.ReviewSection.detailReviewCount.rawValue:
                return viewModel.detailReviewViewModel.detailReviews.count == 0 ? 0 : 1
            case StoreDetailViewModel.ReviewSection.detailReviews.rawValue:
                return viewModel.detailReviewViewModel.detailReviews.count
            default:
                return 0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.mode == .productLists {
            guard let reuseIdentifier = StoreDetailViewModel
                .ProductListSection(rawValue: indexPath.section)?.reuseIdentifier else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            if let cell = cell as? ProductCategoriesCell {
                var categories = [ProductCategory]()
                viewModel.productListViewModel.products.forEach {
                    if !categories.contains($0.category) { categories.append($0.category) }
                }
                cell.categoryButtonTapped = { [weak self] category in
                    self?.viewModel.productListViewModel.categoryButtonDidTapped(category: category)
                    self?.collectionView.reloadSections(
                        IndexSet(integer: StoreDetailViewModel.ProductListSection.productList.rawValue)
                    )
                }
                cell.setUpContents(categories: [ProductCategory.all] + categories)
            }
            if let cell = cell as? ProductListHeaderCell {
                cell.setUpContents(productsCount: viewModel.productListViewModel.products.count)
            }
            if let cell = cell as? ProductCell {
                cell.setUpContents(product: viewModel.productListViewModel.filteredProducts[indexPath.row])
                return cell
            }
            return cell
        } else {
            guard let reuseIdentifier = StoreDetailViewModel.ReviewSection(rawValue: indexPath.section)?.reuseIdentifier else {
                return UICollectionViewCell()
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

            if let cell = cell as? MoveToWriteReviewCell {
                cell.moveToWriteReview = { [weak self] in
                    self?.navigationController?.pushViewController(
                        RegisterReviewViewController(),
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
                    shouldSeeMore: viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
                )

                cell.reloadCell = {
                    self.viewModel.detailReviewViewModel.seeMoreDidTapped(indexPath: indexPath)
                    self.collectionView.reloadItems(at: [indexPath])
                }

                cell.hideSeeMoreButtonIfNeed()
                return cell
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StoreDetailHeaderView.reuseIdentifier,
            for: indexPath) as? StoreDetailHeaderView else { return UICollectionReusableView() }
        header.productListButtonTapped = {
            if self.viewModel.mode != .productLists {
                self.viewModel.mode = .productLists
                collectionView.reloadData()
            }
        }
        header.reviewButtonTapped = {
            if self.viewModel.mode != .reviews {
                self.viewModel.mode = .reviews
                collectionView.reloadData()
            }
        }

        return header
    }
}

extension StoreDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * Constraints.outerCollectionViewInset

        if viewModel.mode == .productLists {
            guard let height = StoreDetailViewModel
                .ProductListSection(rawValue: indexPath.section)?.cellHeight else {
                return .zero
            }
            return CGSize(width: width, height: height)
        } else {
            guard let height = StoreDetailViewModel
                .ReviewSection(rawValue: indexPath.section)?.cellHeight else { return .zero }
            if StoreDetailViewModel.ReviewSection(rawValue: indexPath.section) == .detailReviews {
                let dummyCellForCalculateheight = DetailReviewCell(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                                                 size: CGSize(width: width, height: height)))
                dummyCellForCalculateheight.setUpContents(detailReview: viewModel.detailReviewViewModel.detailReviews[indexPath.row])
                dummyCellForCalculateheight.setUpSeeMore(
                    shouldSeeMore: viewModel.detailReviewViewModel.seeMoreTappedIndexPaths.contains(indexPath)
                )
                let heightThatFits = dummyCellForCalculateheight.systemLayoutSizeFitting(CGSize(width: width, height: height)).height
                return CGSize(width: width, height: heightThatFits)
            } else if StoreDetailViewModel.ReviewSection(rawValue: indexPath.section) == .votedTag {
                let height: CGFloat = viewModel.votedTagViewModel.totalVoteCount < 10 ? 190 : 300
                return CGSize(width: width, height: height)
            }
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = Constraints.outerCollectionViewInset
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard section == 0 else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: Constraints.tabBarHeight)
    }
}

extension StoreDetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let storeInfoViewY = view.frame.minY
        - scrollView.contentOffset.y
        - viewModel.storeDetailInfoViewHeight

        storeDetailInfoView.snp.remakeConstraints {
            $0.top.equalTo(view).offset(storeInfoViewY)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(viewModel.storeDetailInfoViewHeight)
        }

        view.layoutSubviews()
    }
}

// MARK: - StoreDetailInfoStackViewDelegate
extension StoreDetailViewController: StoreDetailInfoStackViewDelegate {
    func callButtonTapped() {
        let phoneNumber = viewModel.storeDetailInfoViewModel.phoneNumber
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func storeLinkButtonTapped() {
        if let url = viewModel.storeDetailInfoViewModel.storeLink,
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    func recommendButtonTapped() {
        // TODO: viewModel에서 UseCase 통해 추천 올리기
    }
}

// MARK: - Constraints Enum
extension StoreDetailViewController {

    enum Constraints {
        static let outerCollectionViewInset: CGFloat = 16
        static let tabBarHeight: CGFloat = 50
    }
}
