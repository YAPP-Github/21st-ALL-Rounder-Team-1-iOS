//
//  StoreDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewController: UIViewController {

    private var viewModel: StoreDetailViewModel!

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
        StoreDetailSection.allCases.forEach {
            collectionView.register($0.cell, forCellWithReuseIdentifier: $0.reuseIdentifier)
        }
        collectionView.dataSource = storeDetailDataSource
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        applyDataSource()
    }

    private func layout() {
        [collectionView, backButton].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
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
            snapShot.appendItems([.productCategory(viewModel.categories)],
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
                cell.setUpContents(categories: self.viewModel.categories)
                cell.setUpContents(productsCount: self.viewModel.products.count)
                cell.categoryButtonTapped = { self.updateProductList(category: $0) }
            }

            if let cell = cell as? ProductCell,
               case let .productList(product) = itemIdentifier {
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

            if let cell = cell as? DetailReviewCell,
               case let .review(review) = itemIdentifier {
                cell.setUpContents(detailReview: review)
            }

            if let cell = cell as? OperationInfoCell,
               case let .operationInfo(operationInfo) = itemIdentifier {
                let shouldShowMore = self.viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath)
                cell.setUpContents(operation: operationInfo, shouldShowMore: shouldShowMore)
                cell.seeMoreTapped = {
                    if self.viewModel.operationInfoSeeMoreIndexPaths.contains(indexPath) {
                        self.viewModel.operationInfoSeeMoreIndexPaths.remove(indexPath)
                    } else {
                        self.viewModel.operationInfoSeeMoreIndexPaths.insert(indexPath)
                    }
                    self.cellTapped(indexPath: indexPath)
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
}

// MARK: - UICollectionViewDelegate
extension StoreDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if section(mode: viewModel.mode, sectionIndex: indexPath.section) != .operationInfo {
            cellTapped(indexPath: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if section(mode: viewModel.mode, sectionIndex: indexPath.section) != .operationInfo {
            cellTapped(indexPath: indexPath)
        }
    }

    private func cellTapped(indexPath: IndexPath) {
        if let item = storeDetailDataSource.itemIdentifier(for: indexPath) {
            var currentSnapshot = storeDetailDataSource.snapshot()
            currentSnapshot.reloadItems([item])
            storeDetailDataSource.apply(currentSnapshot)
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
