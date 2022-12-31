//
//  ProductCategoriesCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class ProductCategoriesCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoriesCell"

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = categoryCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {

    }

    private func categoryCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(20), heightDimension: .estimated(30)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ProductCategoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
