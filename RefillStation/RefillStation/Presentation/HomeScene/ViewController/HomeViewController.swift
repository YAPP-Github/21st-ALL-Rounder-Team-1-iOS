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
    private let searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "가게명, 지명 검색"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.borderColor = Asset.Colors.gray2.color.cgColor
        searchBar.searchTextField.layer.cornerRadius = 4
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.borderStyle = .none
        return searchBar
    }()
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconPosition.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let currentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .captionLarge)
        label.textColor = Asset.Colors.gray5.color
        label.text = "서울 마포구 월드컵로 212"
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()
    private let storeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        // FIXME: 해당부분에 estimatedSize를 view의 frame을 계산해서 넣어주어야 Console에러가 나지 않습니다.
        // UICollectionViewFlowLayout.automaticSize의 height가 50이 반환되는것에 반해 실제 cell의 사이즈는 이보다 크기에
        // console에러가 발생하고 있습니다. 수정 부탁드립니다.
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

    // MARK: - Properties
    private let viewModel = HomeViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        storeCollectionView.dataSource = self
        storeCollectionView.delegate = self
        navigationItem.title = ""
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
        [searchBarView, dividerView, storeCollectionView].forEach { view.addSubview($0) }
        [searchBar, locationIcon, currentLocationLabel].forEach { searchBarView.addSubview($0) }
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(92)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(searchBarView)
        }
        locationIcon.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        currentLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIcon.snp.trailing).offset(6)
            $0.centerY.equalTo(locationIcon)
        }
        storeCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
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
        let headerHeight: CGFloat = viewModel.isServiceRegion ? 0 : 325

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
                productListViewModel: ProductListViewModel(fetchProductListUseCase: FetchProductListUseCase()),
                operationInfoViewModel: OperationInfoViewModel()
            )
        )
        navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
}
