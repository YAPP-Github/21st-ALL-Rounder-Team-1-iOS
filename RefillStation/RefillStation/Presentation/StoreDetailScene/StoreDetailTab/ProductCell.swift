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
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private var pricePerGramLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
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
        pricePerGramLabel.text = "\(product.price)원/\(product.measurement)"
    }

    private func layout() {
        [productImageView, brandLabel, productNameLabel, pricePerGramLabel].forEach { contentView.addSubview($0) }
        productImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(90).priority(.required)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        brandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(productImageView.snp.trailing).offset(12)
        }
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.leading.equalTo(brandLabel)
        }
        pricePerGramLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(productNameLabel)
        }
    }
}
