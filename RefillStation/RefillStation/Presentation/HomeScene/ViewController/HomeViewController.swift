//
//  StoreListViewController.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - UI Components
    private let navigationBar: PumpLargeTitleNavigationBar = {
        let navigationBar = PumpLargeTitleNavigationBar()
        navigationBar.setNavigationTitle("리필스테이션 탐색")
        return navigationBar
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()
    private let storeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(StoreCollectionViewCell.self,
                                forCellWithReuseIdentifier: StoreCollectionViewCell.reuseIdentifier)
        collectionView.register(RegionRequestHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: RegionRequestHeaderView.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 23
        button.layer.borderColor = Asset.Colors.gray2.color.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.06
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
        button.addTarget(self, action: #selector(topButtonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    private let viewModel = HomeViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        storeCollectionView.dataSource = self
        storeCollectionView.delegate = self
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Default Setting Methods

    private func layout() {
        [storeCollectionView, topButton, navigationBar].forEach { view.addSubview($0) }
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(58)
        }
        storeCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        topButton.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
        }
    }

    @objc private func topButtonDidTap() {
        storeCollectionView.setContentOffset(.zero, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stores.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoreCollectionViewCell.reuseIdentifier,
            for: indexPath) as? StoreCollectionViewCell else {
            return UICollectionViewCell()
        }

        let data = viewModel.stores[indexPath.row]
        cell.setUpContents(image: data.thumbnailImageURL,
                           name: data.name,
                           address: data.address,
                           distance: data.distance)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 267)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RegionRequestHeaderView.reuseIdentifier,
            for: indexPath) as? RegionRequestHeaderView else { return UICollectionReusableView() }

        header.moveToRegionRequest = { [weak self] in
            self?.navigationController?.pushViewController(RequestRegionViewController(),
                                                     animated: true)
        }

        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat = viewModel.isServiceRegion ? 0 : 411
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storeDetailViewController = StoreDetailViewController(
            viewModel: StoreDetailViewModel(
                detailReviewViewModel: DetailReviewViewModel(),
                votedTagViewModel: VotedTagViewModel(),
                storeDetailInfoViewModel: StoreDetailInfoViewModel(),
                productListViewModel: ProductListViewModel(fetchProductListUseCase: FetchProductListUseCase())
            )
        )
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}
