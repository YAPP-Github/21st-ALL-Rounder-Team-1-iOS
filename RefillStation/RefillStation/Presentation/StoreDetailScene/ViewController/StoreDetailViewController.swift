//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController, ServerAlertable, LoginAlertable {

    var coordinator: StoreDetailCoordinator?
    private let viewModel: StoreDetailViewModel
    private lazy var storeDetailDataSource = diffableDataSource()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
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
        button.addAction(UIAction { [weak self] _ in
            self?.collectionView.setContentOffset(.zero, animated: true)
        }, for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        let backButtonImage = Asset.Images.iconArrowLeft.image.withRenderingMode(.alwaysTemplate)
        button.setImage(backButtonImage, for: .normal)
        button.tintColor = .white
        if #available(iOS 15, *) {
            button.isHidden = true
        }
        return button
    }()

    init(viewModel: StoreDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCollectionView()
        layout()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        if view.safeAreaInsets.bottom == 0 {
            backButton.snp.remakeConstraints {
                $0.top.equalTo(view).inset(30)
                $0.leading.equalToSuperview().inset(16)
            }
            view.layoutIfNeeded()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        viewModel.viewWillAppear()
        setUpNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        viewModel.viewWillDisappear()
    }

    private func bind() {
        viewModel.applyDataSource = { [weak self] in
            DispatchQueue.main.async {
                self?.applyDataSource()
            }
        }
        viewModel.applyDataSourceWithoutAnimation = { [weak self] in
            DispatchQueue.main.async {
                self?.applyDataSource(withAnimation: false)
            }
        }
        viewModel.showErrorAlert = { [weak self] (title, message) in
            self?.showServerErrorAlert(title: title, message: message)
        }
    }

    private func setUpNavigationBar() {
        let backButtonImage = Asset.Images.iconArrowLeft.image
            .withAlignmentRectInsets(.init(top: 0, left: -8, bottom: 0, right: 0))
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = .white
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        standardAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = viewModel.store.name
        if #available(iOS 15, *) {
            let scrollEdgeAppearance = UINavigationBarAppearance()
            scrollEdgeAppearance.configureWithTransparentBackground()
            scrollEdgeAppearance.backgroundColor = .clear
            scrollEdgeAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            scrollEdgeAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
            navigationController?.navigationBar.tintColor = collectionView.contentOffset.y > 0 ? .black : .white
        } else {
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }

    private func setUpCollectionView() {
        collectionView.dataSource = storeDetailDataSource
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 34, right: 0)
        applyDataSource()
    }

    private func layout() {
        [collectionView, moveToTopButton, backButton].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        moveToTopButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.width.height.equalTo(52)
        }

        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().inset(16)
        }
    }

    private func storeDetailButtonTapped(buttonType: StoreDetailViewModel.StoreInfoButtonType) {
        switch buttonType {
        case .phone:
            let phoneNumber = viewModel.store.phoneNumber
            if !phoneNumber.isEmpty,
               let url = URL(string: "tel://\(phoneNumber.replacingOccurrences(of: "-", with: ""))"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let noLinkPopUp = PumpPopUpViewController(title: nil, description: "전화번호가 등록되지 않은 곳이에요")
                noLinkPopUp.addImageView { imageView in
                    imageView.image = Asset.Images.cryFace.image
                }
                noLinkPopUp.addAction(title: "확인", style: .basic) {
                    noLinkPopUp.dismiss(animated: true)
                }
                present(noLinkPopUp, animated: false)
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
                present(noLinkPopUp, animated: false)
            }
        case .like:
            if UserDefaults.standard.bool(forKey: "isLookAroundUser") {
                loginFeatureButtonTapped(
                    shouldShowPopUp: true,
                    title: "매장 추천은 로그인이 필요해요!",
                    description: nil
                )
            } else {
                viewModel.storeLikeButtonTapped()
            }
        }
    }
}

// MARK: - DiffableDataSource
extension StoreDetailViewController {
    private func applyDataSource(withAnimation: Bool = true) {
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
            snapShot.appendItems([.reviewOverview(viewModel.reviews)], toSection: .reviewOverview)
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
        storeDetailDataSource.apply(snapShot, animatingDifferences: withAnimation)
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
            collectionView: collectionView) { [weak self] (collectionView, indexPath, itemIdentifier) in
                guard let self = self else { return UICollectionViewCell() }
                let storeDetailSection = self.storeSection(mode: self.viewModel.mode, sectionIndex: indexPath.section)
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
        viewModel.categoryButtonDidTapped(category: category)
        var currentSnapshot = storeDetailDataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .productList))
        viewModel.filteredProducts.forEach {
            currentSnapshot.appendItems([.productList($0)])
        }
        storeDetailDataSource.apply(currentSnapshot)
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
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >=
            scrollView.contentSize.height - scrollView.frame.size.height + collectionView.contentInset.bottom {
            navigationController?.navigationBar.tintColor = .black
            moveToTopButton.isHidden = true
            if #unavailable(iOS 15) {
                backButton.isHidden = true
                navigationController?.navigationBar.isHidden = false
            }
        } else if scrollView.contentOffset.y > 0 {
            navigationController?.navigationBar.tintColor = .black
            moveToTopButton.isHidden = false
            if #unavailable(iOS 15) {
                backButton.isHidden = true
                navigationController?.navigationBar.isHidden = false
            }
        } else {
            navigationController?.navigationBar.tintColor = .white
            moveToTopButton.isHidden = true
            if #unavailable(iOS 15) {
                navigationController?.navigationBar.isHidden = true
                backButton.isHidden = false
            }
        }
    }
}

// MARK: - UICollectionViewLayout
extension StoreDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = storeSection(mode: viewModel.mode, sectionIndex: indexPath.section)
        let width = collectionView.frame.width
        let height = section.cellHeight

        if section == .review {
            let dummyCellForCalculateheight = DetailReviewCell(
                frame: CGRect(origin: .zero, size: CGSize(width: width, height: height))
            )
            dummyCellForCalculateheight.setUpContents(
                review: viewModel.reviews[indexPath.row],
                shouldSeeMore: viewModel.reviewSeeMoreIndexPaths.contains(indexPath),
                screenWidth: view.frame.width
            )
            let heightThatFits = dummyCellForCalculateheight
                .systemLayoutSizeFitting(CGSize(width: width, height: height)).height
            return CGSize(width: width, height: heightThatFits)
        } else if section == .operationInfo {
            let dummyCellForCalculateheight = OperationInfoCell(
                frame: CGRect(origin: .zero, size: CGSize(width: width, height: height))
            )
            let shouldShowMore = viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath)
            dummyCellForCalculateheight.setUpContents(
                operation: viewModel.operationInfos[indexPath.row],
                shouldShowMore: shouldShowMore,
                screenWidth: view.frame.width
            )
            let heightThatFits = dummyCellForCalculateheight
                .systemLayoutSizeFitting(CGSize(width: width, height: height)).height
            return CGSize(width: width, height: heightThatFits)
        } else if section == .reviewOverview && viewModel.totalTagVoteCount < 10 {
                return CGSize(width: width, height: 414)
        } else if section == .storeDetailInfo {
            let dummyCellForCalculateheight = StoreDetailInfoViewCell(
                frame: CGRect(origin: .zero, size: CGSize(width: width, height: height))
            )
            dummyCellForCalculateheight.setUpContents(store: viewModel.store, screenWidth: view.frame.width)
            let heightThatFits = dummyCellForCalculateheight
                .systemLayoutSizeFitting(CGSize(width: width, height: height)).height
            return CGSize(width: width, height: heightThatFits)
        }

        return CGSize(width: width, height: height)
    }
}

// MARK: - Cell Registration
extension StoreDetailViewController {
    private func storeDetailInfoCellRegisration() -> UICollectionView.CellRegistration<StoreDetailInfoViewCell, StoreDetailItem> {
        return UICollectionView
            .CellRegistration<StoreDetailInfoViewCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard case let .storeDetailInfo(store) = item else { return }
                cell.setUpContents(store: store)
                cell.storeButtonTapped = { [weak self] in
                    guard let self = self else { return }
                    self.storeDetailButtonTapped(buttonType: $0)
                }
                cell.checkVisitGuideButtonTapped = { [weak self] in
                    guard let self = self else { return }
                    let imagePaths = self.viewModel.store.storeRefillGuideImagePaths
                    self.coordinator?.refillGuideButtonTapped(imagePaths: imagePaths)
                }
            }
    }

    private func tabBarCellRegistration() -> UICollectionView.CellRegistration<StoreDetailTabBarCell, StoreDetailItem> {
        return UICollectionView
            .CellRegistration<StoreDetailTabBarCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard let self = self else { return }
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
        return UICollectionView
            .CellRegistration<ProductCategoriesCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard let self = self else { return }
                cell.setUpContents(info: .init(categories: self.viewModel.categories,
                                               currentFilter: self.viewModel.currentCategoryFilter))
                cell.categoryButtonTapped = { [weak self] in
                    guard let self = self else { return }
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
        return UICollectionView
            .CellRegistration<ReviewInfoCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard let self = self else { return }
                cell.moveToRegisterReview = { [weak self] in
                    if UserDefaults.standard.bool(forKey: "isLookAroundUser") {
                        self?.loginFeatureButtonTapped(
                            shouldShowPopUp: true,
                            title: "리뷰 쓰기는 로그인이 필요해요!",
                            description: nil
                        )
                    } else {
                        self?.coordinator?.showRegisterReview()
                    }
                }
                cell.setUpContents(totalDetailReviewCount: self.viewModel.reviews.count,
                                   totalTagReviewCount: self.viewModel.totalTagVoteCount,
                                   rankTags: self.viewModel.rankTags)
            }
    }

    private func detailReviewCellRegistration() -> UICollectionView.CellRegistration<DetailReviewCell, StoreDetailItem> {
        return UICollectionView
            .CellRegistration<DetailReviewCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard case let .review(review) = item, let self = self else { return }
                let shouldSeeMore = self.viewModel.reviewSeeMoreIndexPaths.contains(indexPath)
                cell.setUpContents(review: review, shouldSeeMore: shouldSeeMore)
                cell.photoImageTapped = { [weak self] in
                    self?.coordinator?.showDetailPhotoReview(photoURLs: review.imageURL)
                }
                cell.seeMoreTapped = { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.reviewSeeMoreTapped(indexPath: indexPath)
                    self.reloadCellAt(indexPath: indexPath)
                }
                cell.reportButtonTapped = { [weak self] in
                    if UserDefaults.standard.bool(forKey: "isLookAroundUser") {
                        self?.coordinator?.showLookAroundLogin()
                        return
                    }
                    let reportPopUp = ReviewReportPopUpViewController(
                        viewModel: ReviewReportPopUpViewModel(reportedUserId: review.userId)
                    ) {
                        let reportCompletePopUp = PumpPopUpViewController(
                            title: "해당 댓글이 신고처리 되었습니다.",
                            description: "검토 후 빠른 시일 내에 반영하겠습니다."
                        )
                        reportCompletePopUp.addAction(title: "확인", style: .basic) { [weak self] in
                            self?.dismiss(animated: true)
                        }
                        self?.present(reportCompletePopUp, animated: false)
                    }
                    self?.present(reportPopUp, animated: false)
                }
            }
    }

    private func operationNoticeCellRegistration() -> UICollectionView.CellRegistration<OperationNoticeCell, StoreDetailItem> {
        return UICollectionView.CellRegistration<OperationNoticeCell, StoreDetailItem> { cell, indexPath, item in
        }
    }

    private func operationInfoCellRegistration() -> UICollectionView.CellRegistration<OperationInfoCell, StoreDetailItem> {
        return UICollectionView
            .CellRegistration<OperationInfoCell, StoreDetailItem> { [weak self] (cell, indexPath, item) in
                guard case let .operationInfo(operationInfo) = item, let self = self else { return }
                let shouldShowMore = self.viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath)
                cell.setUpContents(
                    operation: operationInfo,
                    shouldShowMore: shouldShowMore
                )
                cell.seeMoreTapped = { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.operationInfoSeeMoreTapped(indexPath: indexPath)
                    self.reloadCellAt(indexPath: indexPath)
                }
            }
    }
}
