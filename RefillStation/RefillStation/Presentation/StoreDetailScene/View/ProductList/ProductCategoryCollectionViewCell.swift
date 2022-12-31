//
//  ProductCategoryCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class ProductCategoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoryCollectionViewCell"

    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        button.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        button.titleLabel?.font = UIFont.font(style: .buttomMedium)
        return button
    }()

    var categoryButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpContents(title: String) {
        categoryButton.setTitle(title, for: .normal)
    }

    private func layout() {
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    private func setUpLayer() {
        layer.cornerRadius = 25
        layer.borderColor = Asset.Colors.gray4.color.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }

    @objc
    private func categoryButtonTapped(_ sender: UIButton) {
        categoryButtonTapped?()
    }
}
