//
//  ProductCategoryCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit
import RxSwift
import RxCocoa

final class ProductCategoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoryCollectionViewCell"

//    weak var viewModel: ProductListViewModel?
    private var category: ProductCategory?

    override var isSelected: Bool {
        didSet {
            isSelected ? setUpSelected() : setUpDeselected()
        }
    }

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        label.font = UIFont.font(style: .buttonMedium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents2(viewModel: ProductListViewModel) {
//        self.viewModel = viewModel
    }

    func setUpContents(category: ProductCategory) {
        self.category = category
        categoryLabel.text = category.title
        if category == .all {
            setUpSelected()
        } else {
            setUpDeselected()
        }
    }

    private func layout() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    private func setUpDeselected() {
        layer.cornerRadius = 16
        layer.borderColor = Asset.Colors.gray4.color.cgColor
        categoryLabel.textColor = Asset.Colors.gray4.color
        layer.borderWidth = 1
        clipsToBounds = true
    }

    private func setUpSelected() {
        layer.cornerRadius = 16
        layer.borderColor = Asset.Colors.primary3.color.cgColor
        layer.borderWidth = 1
        categoryLabel.textColor = Asset.Colors.primary3.color
        clipsToBounds = true
    }
}
