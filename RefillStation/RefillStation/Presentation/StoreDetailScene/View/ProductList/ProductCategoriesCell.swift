//
//  ProductCategoriesCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class ProductCategoriesCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoriesCell"

    private(set) var categories: [ProductCategory]?
    private let indexPathForAll = IndexPath(row: 0, section: 0)

    private let productsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = categoryCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var categoryButtonTapped: ((ProductCategory?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(categories: [ProductCategory]) {
        self.categories = [ProductCategory.all] + categories
        categoryCollectionView.selectItem(at: indexPathForAll,
                                          animated: true, scrollPosition: .left)
    }

    func setUpContents(productsCount: Int) {
        productsCountLabel.text = "판매상품 \(productsCount)건"
    }

    private func layout() {
        [categoryCollectionView, productsCountLabel].forEach {
            contentView.addSubview($0)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        productsCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
        }
    }

    private func categoryCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .estimated(35)))
        item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(100), heightDimension: .estimated(35)), subitems: [item])
        // group widthDimension의 fractionalWidth가 100인 이유는 item의 길이보다 group의 fractionalWidth가 짧으면
        // UIKit이 자체적으로 group내의 subitem의 개수를 늘려 group이 두개가 되는데 이는 continuos scroll을 방해하기 때문입니다.
        // fractionalWidth를 100이라는 보수적인 숫자로 설정하여 continuos scroll을 방해하지 않도록 하였습니다.
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ProductCategoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProductCategoryCollectionViewCell,
              let categories = categories else { return UICollectionViewCell() }

        cell.setUpContents(category: categories[indexPath.row])
        return cell
    }
}

extension ProductCategoriesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        categoryButtonTapped?(categories[indexPath.row])
    }
}
