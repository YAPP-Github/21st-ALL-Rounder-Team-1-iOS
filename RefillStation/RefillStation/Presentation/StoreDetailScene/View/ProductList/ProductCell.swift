//
//  ProductCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = "productCell"

    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray1.color
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
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

    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.primary2.color
        return label
    }()

    private var pricePerGramLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
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

    func setUpImage(image: UIImage) {
        productImageView.image = image
    }

    func setUpContents(product: Product) {
        brandLabel.text = product.brand
        productNameLabel.text = product.name
        priceLabel.text = "\(product.price)원"
        pricePerGramLabel.text = "/\(product.measurement)"
    }

    private func layout() {
        [productImageView, brandLabel, productNameLabel, priceLabel, pricePerGramLabel, divisionLine].forEach {
            contentView.addSubview($0)
        }
        productImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.top.equalToSuperview().inset(16)
        }
        brandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(productImageView.snp.trailing).offset(12)
        }
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.leading.equalTo(brandLabel)
        }
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(productNameLabel)
        }

        pricePerGramLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(priceLabel.snp.trailing)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
