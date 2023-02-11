//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController {

    var coordinator: StoreDetailCoordinator?
    private var viewModel: StoreDetailViewModel!
    private lazy var storeDetailDataSource = diffableDataSource()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        return collectionView
    }()

    private lazy var moveToTopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 26
        button.layer.borderColor = Asset.Colors.gray2.color.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.06
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
        button.addAction(UIAction { _ in
            self.collectionView.setContentOffset(.zero, animated: true)
        }, for: .touchUpInside)
        button.isHidden = true
        return button
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
        setUpCollectionView()
        layout()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        tabBarController?.tabBar.isHidden = true
        viewModel.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        navigationController?.navigationBar.tintColor = .black
        tabBarController?.tabBar.isHidden = false
        viewModel.viewWillDisappear()
    }

    private func bind() {
        viewModel.applyDataSource = {
            DispatchQueue.main.async { [weak self] in
                self?.applyDataSource()
            }
        }
    }

    private func setUpNavigationBar() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = .white
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundColor = .clear
        scrollEdgeAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = viewModel.store.name
    }

    private func setUpCollectionView() {
        collectionView.dataSource = storeDetailDataSource
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        applyDataSource()
    }

    private func layout() {
        [collectionView, moveToTopButton].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        moveToTopButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.width.height.equalTo(52)
        }
    }

    private func storeDetailButtonTapped(buttonType: StoreDetailViewModel.StoreInfoButtonType) {
        switch buttonType {
        case .phone:
            let phoneNumber = viewModel.store.phoneNumber
            if let url = URL(string: "tel://\(phoneNumber)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case .link:
            if let url = URL(string: viewModel.store.snsAddress),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                let noLinkPopUp = PumpPopUpViewController(title: nil, description: "매장 링크가 등록되지 않은 곳이에요")
                noLinkPopUp.addImageView { imageView in
                    imageView.image = Asset.Images.cryFace.image
                }
                noLinkPopUp.addAction(title: "확인", style: .basic) {
                    noLinkPopUp.dismiss(animated: true)
                }
                present(noLinkPopUp, animated: true)
            }
        case .like:
            viewModel.storeLikeButtonTapped()
        }
    }
}

// MARK: - DiffableDataSource
extension StoreDetailViewController {
    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<StoreDetailSection, StoreDetailItem>()
        switch viewModel.mode {
        case .productLists:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .productCategory, .filteredProductsCount, .productList])
            snapShot.appendItems([.productCategory(.init(categories: viewModel.categories,
                                                         currentFilter: viewModel.currentCategoryFilter))],
                                 toSection: .productCategory)
            snapShot.appendItems([.filteredProduct(viewModel.filteredProducts.count)],
                                 toSection: .filteredProductsCount)
            viewModel.filteredProducts.forEach {
                snapShot.appendItems([.productList($0)], toSection: .productList)
            }
        case .reviews:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .reviewOverview, .review])
            snapShot.appendItems([.reviewOverview(viewModel.rankTags)], toSection: .reviewOverview)
            viewModel.reviews.forEach {
                snapShot.appendItems([.review($0)], toSection: .review)
            }
        case .operationInfo:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .operationNotice, .operationInfo])
            snapShot.appendItems([.oprationNotice("")], toSection: .operationNotice)
            viewModel.operationInfos.forEach {
                snapShot.appendItems([.operationInfo($0)], toSection: .operationInfo)
            }
        }
        snapShot.appendItems([.storeDetailInfo(viewModel.store)],
                             toSection: .storeDetailInfo)
        snapShot.appendItems([.tabBarMode(viewModel.mode)], toSection: .tabBar)
        storeDetailDataSource.apply(snapShot)
    }

    private func diffableDataSource() -> UICollectionViewDiffableDataSource<StoreDetailSection, StoreDetailItem> {
        let storeDetailInfoCellRegisration = storeDetailInfoCellRegisration()
        let tabBarCellRegistration = tabBarCellRegistration()
        let productCategoriesCellRegistration = productCategoriesCellRegistration()
        let filteredCellRegistration = filteredCellRegistration()
        let productCellRegistration = productCellRegistration()
        let reviewInfoCellRegistration = reviewInfoCellRegistration()
        let detailReviewCellRegistration = detailReviewCellRegistration()
        let operationNoticeCellRegistration = operationNoticeCellRegistration()
        let operationInfoCellRegistration = operationInfoCellRegistration()
        return UICollectionViewDiffableDataSource<StoreDetailSection, StoreDetailItem>(
            collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
                let storeDetailSection = self.section(mode: self.viewModel.mode, sectionIndex: indexPath.section)
                switch storeDetailSection {
                case .storeDetailInfo:
                    return collectionView.dequeueConfiguredReusableCell(using: storeDetailInfoCellRegisration,
                                                                        for: indexPath, item: itemIdentifier)
                case .tabBar:
                    return collectionView.dequeueConfiguredReusableCell(using: tabBarCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .productCategory:
                    return collectionView.dequeueConfiguredReusableCell(using: productCategoriesCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .filteredProductsCount:
                    return collectionView.dequeueConfiguredReusableCell(using: filteredCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .productList:
                    return collectionView.dequeueConfiguredReusableCell(using: productCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .reviewOverview:
                    return collectionView.dequeueConfiguredReusableCell(using: reviewInfoCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .review:
                    return collectionView.dequeueConfiguredReusableCell(using: detailReviewCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .operationNotice:
                    return collectionView.dequeueConfiguredReusableCell(using: operationNoticeCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                case .operationInfo:
                    return collectionView.dequeueConfiguredReusableCell(using: operationInfoCellRegistration,
                                                                        for: indexPath, item: itemIdentifier)
                }
            }
    }

    private func updateProductList(category: ProductCategory?) {
        guard let category = category else { return }
        self.viewModel.categoryButtonDidTapped(category: category)
        var currentSnapshot = self.storeDetailDataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .productList))
        self.viewModel.filteredProducts.forEach {
            currentSnapshot.appendItems([.productList($0)])
        }
        self.storeDetailDataSource.apply(currentSnapshot)
    }

    private func updateFilteredProductCountCell() {
        var currentSnapshot = storeDetailDataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .filteredProductsCount))
        currentSnapshot.appendItems([.filteredProduct(viewModel.filteredProducts.count)],
                                    toSection: .filteredProductsCount)
        storeDetailDataSource.apply(currentSnapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension StoreDetailViewController: UICollectionViewDelegate {
    private func reloadCellAt(indexPath: IndexPath) {
        if let item = storeDetailDataSource.itemIdentifier(for: indexPath) {
            var currentSnapshot = storeDetailDataSource.snapshot()
            currentSnapshot.reloadItems([item])
            storeDetailDataSource.apply(currentSnapshot)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            navigationController?.navigationBar.tintColor = .black
            moveToTopButton.isHidden = false
        } else {
            navigationController?.navigationBar.tintColor = .white
            moveToTopButton.isHidden = true
        }
    }
}

// MARK: - Constraints Enum
extension StoreDetailViewController {
    enum Constraints {
        static let outerCollectionViewInset: CGFloat = 16
        static let tabBarHeight: CGFloat = 50
    }
}

// MARK: - UICollectionViewLayout
extension StoreDetailViewController {
    private func compositionalLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 0
        configuration.scrollDirection = .vertical

        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            let storeDetailSection = self.section(mode: self.viewModel.mode, sectionIndex: section)
            let itemHeight = storeDetailSection.cellHeight
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .estimated(itemHeight)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                           heightDimension: .estimated(itemHeight)),
                                                         subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = storeDetailSection.contentInset
            return section
        }, configuration: configuration)

        return compositionalLayout
    }
}

// MARK: - Cell Registration
extension StoreDetailViewController {
    private func storeDetailInfoCellRegisration() -> UICollectionView.CellRegistration<StoreDetailInfoViewCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<StoreDetailInfoViewCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .storeDetailInfo(store) = item else { return }
            cell.setUpContents(store: store)
            cell.storeButtonTapped = { self.storeDetailButtonTapped(buttonType: $0) }
        }
    }

    private func tabBarCellRegistration() -> UICollectionView.CellRegistration<StoreDetailTabBarCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<StoreDetailTabBarCell, StoreDetailItem> { cell, indexPath, item in
            cell.headerTapped = { [weak self] mode in
                if self?.viewModel.mode != mode {
                    self?.viewModel.mode = mode
                    self?.applyDataSource()
                }
            }
            cell.setUpContents(mode: self.viewModel.mode)
        }
    }

    private func productCategoriesCellRegistration() -> UICollectionView.CellRegistration<ProductCategoriesCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<ProductCategoriesCell, StoreDetailItem> { cell, indexPath, item in
            cell.setUpContents(info: .init(categories: self.viewModel.categories,
                                           currentFilter: self.viewModel.currentCategoryFilter))
            cell.categoryButtonTapped = {
                self.updateProductList(category: $0)
                self.updateFilteredProductCountCell()
            }
        }
    }

    private func filteredCellRegistration() -> UICollectionView.CellRegistration<FilteredProductCountCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<FilteredProductCountCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .filteredProduct(count) = item else { return }
            cell.setUpContents(filteredCount: count)
        }
    }

    private func productCellRegistration() -> UICollectionView.CellRegistration<ProductCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<ProductCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .productList(product) = item else { return }
            cell.setUpContents(product: product)
        }
    }

    private func reviewInfoCellRegistration() -> UICollectionView.CellRegistration<ReviewInfoCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<ReviewInfoCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .reviewOverview(rankTags) = item else { return }
            cell.moveToRegisterReview = { [weak self] in
                self?.coordinator?.showRegisterReview()
            }
            cell.setUpContents(totalDetailReviewCount: self.viewModel.reviews.count,
                               totalTagReviewCount: self.viewModel.totalTagVoteCount,
                               rankTags: rankTags)
        }
    }

    private func detailReviewCellRegistration() -> UICollectionView.CellRegistration<DetailReviewCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<DetailReviewCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .review(review) = item else { return }
            let shouldSeeMore = self.viewModel.reviewSeeMoreIndexPaths.contains(indexPath)
            cell.setUpContents(review: review, shouldSeeMore: shouldSeeMore)
            cell.photoImageTapped = { [weak self] in
                self?.coordinator?.showDetailPhotoReview(photoURLs: review.imageURL)
            }
            cell.seeMoreTapped = {
                self.viewModel.reviewSeeMoreTapped(indexPath: indexPath)
                self.reloadCellAt(indexPath: indexPath)
            }
            cell.reportButtonTapped = { [weak self] in
                let reportPopUp = ReviewReportPopUpViewController(
                    viewModel: ReviewReportPopUpViewModel(reportedUserId: review.userId)
                ) {
                    let reportCompletePopUp = PumpPopUpViewController(title: nil,
                                                                description: "해당 댓글이 신고처리 되었습니다.")
                    reportCompletePopUp.addAction(title: "확인", style: .basic) {
                        self?.dismiss(animated: true)
                    }
                    self?.present(reportCompletePopUp, animated: true)
                }
                self?.present(reportPopUp, animated: true)
            }
        }
    }

    private func operationNoticeCellRegistration() -> UICollectionView.CellRegistration<OperationNoticeCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<OperationNoticeCell, StoreDetailItem> { cell, indexPath, item in
        }
    }
    private func operationInfoCellRegistration() -> UICollectionView.CellRegistration<OperationInfoCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<OperationInfoCell, StoreDetailItem> { cell, indexPath, item in
            guard case let .operationInfo(operationInfo) = item else { return }
            let shouldShowMore = self.viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath)
            cell.setUpContents(operation: operationInfo, shouldShowMore: shouldShowMore)
            cell.seeMoreTapped = {
                self.viewModel.operationInfoSeeMoreTapped(indexPath: indexPath)
                self.reloadCellAt(indexPath: indexPath)
            }
        }
    }
}
