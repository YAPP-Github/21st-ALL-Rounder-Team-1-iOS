//
//  ProductListHeaderCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/23.
//

import UIKit

final class ProductListHeaderCell: UICollectionViewCell {
    static let reuseIdentifier = "productListHeaderCell"

    private let productsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(productsCount: Int) {
        productsCountLabel.text = "판매상품 \(productsCount)건"
    }

    private func layout() {
        contentView.addSubview(productsCountLabel)

        productsCountLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
