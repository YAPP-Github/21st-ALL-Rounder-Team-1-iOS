//
//  ProductCategoryCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class ProductCategoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoryCollectionViewCell"

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpContents(title: String) {
        categoryLabel.text = title
    }

    private func layout() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
