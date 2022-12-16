//
//  ProductTableViewCell.swift
//  RefillStation
//
//  Created by kong on 2022/11/27.
//

import UIKit
import SnapKit

final class ProductTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ProductTableViewCell"

    // MARK: - UIComponents
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

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

// MARK: - Default Setting Methods
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

    func setUpImage(image: UIImage) {
        productImageView.image = image
    }

    func setUpContents(productName: String,
                       imageURL: String?,
                       brand: String,
                       price: Int) {
        /*
        if let imageURL = imageURL {
         // 킹피셔 등을 통해 이미지를 캐싱해 이미지를 로드하는 작업 필요
        } else {
         // 성공적으로 로드하지 못했을 경우나 서버에 이미지가 없을 경우, empty view 처리
        }
        */
        brandLabel.text = brand
        productNameLabel.text = productName
        pricePerGramLabel.text = "\(price)원/g"
    }
}
