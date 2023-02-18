//
//  FilteredProductCountCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/17.
//

import UIKit

final class FilteredProductCountCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: FilteredProductCountCell.self)

    private let productsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(filteredCount: Int) {
        productsCountLabel.setText(text: "판매상품 \(filteredCount)건", font: .bodyMedium)
    }

    private func layout() {
        contentView.addSubview(productsCountLabel)
        productsCountLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
