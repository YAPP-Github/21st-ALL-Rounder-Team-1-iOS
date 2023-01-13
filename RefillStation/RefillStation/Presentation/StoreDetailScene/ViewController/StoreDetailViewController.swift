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
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func bind() {
        viewModel.reloadItemsAt = { [weak self] indexPaths in
            self?.collectionView.reloadItems(at: indexPaths)
        }
    }

    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = ""
    }

    private func setUpCollectionView() {
        collectionView.register(StoreInfoViewCell.self,
                                forCellWithReuseIdentifier: StoreInfoViewCell.reuseIdentifier)

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

        collectionView.register(OperationInfoCell.self,
                                forCellWithReuseIdentifier: OperationInfoCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.showsVerticalScrollIndicator = false
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
}

extension StoreDetailViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        switch viewModel.mode {
        case .productLists:
            return 2 + viewModel.productListViewModel.filteredProducts.count
        case .reviews:
            var reviewSectionItemCount = 1
            if viewModel.votedTagViewModel.totalVoteCount != 0 {
                reviewSectionItemCount = viewModel.withoutReviewCount + viewModel.detailReviewViewModel.detailReviews.count
            }
            return reviewSectionItemCount
        case .operationInfo:
            return viewModel.operationInfoViewModel.operationInfos.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreInfoViewCell.reuseIdentifier, for: indexPath) as? StoreInfoViewCell else { return UICollectionViewCell() }
            cell.setUpContents(viewModel: viewModel.storeDetailInfoViewModel,
                               delegate: self)
            return cell
        }
        if viewModel.mode == .productLists {
            let reuseIdentifier = viewModel.productListSection(for: indexPath).reuseIdentifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            if let cell = cell as? ProductCategoriesCell {
//                var categories = [ProductCategory]()
//                viewModel.productListViewModel.products.forEach {
//                    if !categories.contains($0.category) { categories.append($0.category) }
//                }
                cell.setUpContents2(viewModel: viewModel.productListViewModel)
//                if cell.categories == nil {
//                    cell.setUpContents(categories: [ProductCategory.all] + categories)
//                }
//                cell.categoryButtonTapped = { [weak self] category in
//                    guard let self = self else { return }
//                    self.viewModel.productListViewModel.categoryButtonDidTapped(category: category)
//                    self.collectionView.reloadItems(
//                        at: (2..<2 + self.viewModel.productListViewModel.filteredProducts.count).map {
//                            return IndexPath(row: $0, section: 1)
//                        }
//                    )
//                }
            }
            if let cell = cell as? ProductListHeaderCell {
                cell.setUpContents(productsCount: viewModel.productListViewModel.products.count)
            }
            if let cell = cell as? ProductCell {
                cell.setUpContents(product: viewModel.productListViewModel.filteredProducts[indexPath.row - 2])
                return cell
            }
            return cell
        } else if viewModel.mode == .reviews {
            let reuseIdentifier = viewModel.reviewListSection(for: indexPath).reuseIdentifier

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
                cell.setUpContents(detailReview: viewModel.detailReviewViewModel.detailReviews[indexPath.row - viewModel.withoutReviewCount])

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
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OperationInfoCell.reuseIdentifier, for: indexPath) as? OperationInfoCell else { return UICollectionViewCell() }

            cell.setUpContents(operation: self.viewModel.operationInfoViewModel.operationInfos[indexPath.row], shouldShowSeeMore: true)

            cell.setUpSeeMore(
                shouldSeeMore: viewModel.operationInfoViewModel.seeMoreTappedIndexPaths.contains(indexPath)
            )

            cell.reloadCell = {
                self.viewModel.operationInfoViewModel.seeMoreDidTapped(indexPath: indexPath)
                collectionView.reloadItems(at: [indexPath])
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StoreDetailHeaderView.reuseIdentifier,
            for: indexPath) as? StoreDetailHeaderView else { return UICollectionReusableView() }
        header.headerTapped = { [weak self] mode in
            if self?.viewModel.mode != mode {
                self?.viewModel.mode = mode
                collectionView.reloadData()
            }
        }
        if indexPath.section == 1 {
            header.setUpContents()
        } else {
            header.removeContents()
        }
        return header
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

extension StoreDetailViewController {
    private func compositionalLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 0
        configuration.scrollDirection = .vertical

        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            var layoutSection: NSCollectionLayoutSection
            if section == 0 {
                layoutSection = StoreDetailViewModel.StoreInfoSection.main.section
            } else {
                switch self.viewModel.mode {
                case .productLists:
                    layoutSection = StoreDetailViewModel.ProductListSection(rawValue: section)!.section
                case .reviews:
                    layoutSection = StoreDetailViewModel.ReviewSection(rawValue: section)!.section
                case .operationInfo:
                    layoutSection = StoreDetailViewModel.OperationInfoSection.main.section
                }
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(300)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                layoutSection.boundarySupplementaryItems = [header]
            }
            return layoutSection
        }, configuration: configuration)

        return compositionalLayout
    }
}
