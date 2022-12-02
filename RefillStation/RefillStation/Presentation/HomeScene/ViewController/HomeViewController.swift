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
    private var storeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(StoreCollectionViewCell.self,
                                forCellWithReuseIdentifier: StoreCollectionViewCell.reuseIdentifier)
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
        layout()
    }
    // MARK: - Default Setting Methods

    private func layout() {
        [storeCollectionView].forEach { view.addSubview($0) }
        storeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        cell.setUpContents(image: data.imageURL,
                           name: data.name,
                           address: data.address,
                           distance: data.distance,
                           openState: data.openState,
                           time: data.closeTime)
        return cell
    }
}
