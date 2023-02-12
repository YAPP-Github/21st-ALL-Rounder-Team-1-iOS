//
//  ProductCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ProductCell.self)

    private var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .captionLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleSmall)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(product: Product) {
        brandLabel.setText(text: product.brand, font: .captionLarge)
        productNameLabel.setText(text: product.brand, font: .titleSmall)
    }

    private func layout() {
        [brandLabel, productNameLabel, divisionLine].forEach {
            contentView.addSubview($0)
        }
        brandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.leading.equalTo(brandLabel)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
