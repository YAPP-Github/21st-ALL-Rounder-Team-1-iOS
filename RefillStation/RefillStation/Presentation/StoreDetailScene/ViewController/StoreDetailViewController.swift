//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController {

    private var viewModel: StoreDetailViewModel!

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        return collectionView
    }()

    private lazy var storeDetailDataSource = diffableDataSource()

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

    private func setUpNavigationBar() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundColor = .white
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundColor = .clear
        scrollEdgeAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = viewModel.store.name
    }

    private func setUpCollectionView() {
        StoreDetailSection.allCases.forEach {
            collectionView.register($0.cell, forCellWithReuseIdentifier: $0.reuseIdentifier)
        }
        collectionView.dataSource = storeDetailDataSource
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        applyDataSource()
    }

    private func layout() {
        [collectionView].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
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
            }
        case .like:
            break
        }
    }
}

// MARK: - DiffableDataSource
extension StoreDetailViewController {
    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<StoreDetailSection, StoreDetailItem>()
        switch viewModel.mode {
        case .productLists:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .productCategory, .productList])
            snapShot.appendItems([.productCategory(.init(categories: viewModel.categories,
                                                         currentFilter: viewModel.currentCategoryFilter,
                                                         filteredCount: viewModel.filteredProducts.count))],
                                 toSection: .productCategory)
            viewModel.filteredProducts.forEach {
                snapShot.appendItems([.productList($0)], toSection: .productList)
            }
        case .reviews:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .reviewOverview, .review])
            snapShot.appendItems([.reviewOverview(viewModel.tagReviews)], toSection: .reviewOverview)
            viewModel.detailReviews.forEach {
                snapShot.appendItems([.review($0)], toSection: .review)
            }
        case .operationInfo:
            snapShot.appendSections([.storeDetailInfo, .tabBar, .operationInfo])
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
        return UICollectionViewDiffableDataSource<StoreDetailSection, StoreDetailItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in

            let storeDetailSection = self.section(mode: self.viewModel.mode, sectionIndex: indexPath.section)
            let reuseIdentifier = storeDetailSection.reuseIdentifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

            if let cell = cell as? StoreDetailInfoViewCell {
                cell.setUpContents(storeName: self.viewModel.store.name,
                                   storeAddress: self.viewModel.store.address)
                cell.storeButtonTapped = { buttonType in
                    self.storeDetailButtonTapped(buttonType: buttonType)
                }
            }

            if let cell = cell as? StoreDetailTabBarCell {
                cell.headerTapped = { [weak self] mode in
                    if self?.viewModel.mode != mode {
                        self?.viewModel.mode = mode
                        self?.applyDataSource()
                    }
                }
                cell.setUpContents(mode: self.viewModel.mode)
            }

            if let cell = cell as? ProductCategoriesCell {
                cell.setUpContents(info: .init(categories: self.viewModel.categories,
                                               currentFilter: self.viewModel.currentCategoryFilter,
                                               filteredCount: self.viewModel.filteredProducts.count))
                cell.categoryButtonTapped = {
                    self.updateProductList(category: $0)
                    self.updateProductCategoriesCell()
                }
            }

            if let cell = cell as? ProductCell, case let .productList(product) = itemIdentifier {
                cell.setUpContents(product: product)
            }

            if let cell = cell as? ReviewInfoCell {
                cell.moveToRegisterReview = { [weak self] in
                    self?.navigationController?.pushViewController(RegisterReviewViewController(), animated: true)
                }
                cell.setUpContents(totalVote: self.viewModel.totalVoteCount)
                cell.setUpContents(tagReviews: self.viewModel.tagReviews)
                cell.setUpContents(totalDetailReviewCount: self.viewModel.detailReviews.count)
            }

            if let cell = cell as? DetailReviewCell, case let .review(review) = itemIdentifier {
                cell.setUpContents(detailReview: review)
            }

            if let cell = cell as? OperationInfoCell,
               case let .operationInfo(operationInfo) = itemIdentifier {
                let shouldShowMore = self.viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath)
                cell.setUpContents(operation: operationInfo, shouldShowMore: shouldShowMore)
                cell.seeMoreTapped = {
                    self.viewModel.operationInfoSeeMoreTapped(indexPath: indexPath)
                    self.reloadCellAt(indexPath: indexPath)
                }
            }

            return cell
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

    private func updateProductCategoriesCell() {
        var currentSnapshot = storeDetailDataSource.snapshot()
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: .productCategory))
        currentSnapshot.appendItems([.productCategory(.init(categories: viewModel.categories,
                                                            currentFilter: viewModel.currentCategoryFilter,
                                                            filteredCount: viewModel.filteredProducts.count))],
                                    toSection: .productCategory)
        storeDetailDataSource.apply(currentSnapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension StoreDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if section(mode: viewModel.mode, sectionIndex: indexPath.section) != .operationInfo {
            reloadCellAt(indexPath: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if section(mode: viewModel.mode, sectionIndex: indexPath.section) != .operationInfo {
            reloadCellAt(indexPath: indexPath)
        }
    }

    private func reloadCellAt(indexPath: IndexPath) {
        if let item = storeDetailDataSource.itemIdentifier(for: indexPath) {
            var currentSnapshot = storeDetailDataSource.snapshot()
            currentSnapshot.reloadItems([item])
            storeDetailDataSource.apply(currentSnapshot)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.tintColor = .white
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

    private func section(mode: StoreDetailViewModel.TabBarMode, sectionIndex: Int) -> StoreDetailSection {
        if sectionIndex == StoreDetailSection.storeDetailInfo.sectionIndex {
            return StoreDetailSection.storeDetailInfo
        } else if sectionIndex == StoreDetailSection.tabBar.sectionIndex {
            return StoreDetailSection.tabBar
        }

        switch mode {
        case .productLists:
            if sectionIndex == 2 {
                return StoreDetailSection.productCategory
            } else if sectionIndex == 3 {
                return StoreDetailSection.productList
            }
        case .reviews:
            if sectionIndex == 2 {
                return StoreDetailSection.reviewOverview
            } else if sectionIndex == 3 {
                return StoreDetailSection.review
            }
        case .operationInfo:
            return StoreDetailSection.operationInfo
        }

        return .storeDetailInfo
    }
}
