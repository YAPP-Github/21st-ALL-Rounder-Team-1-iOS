//
//  ReviewDescriptionCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewDescriptionCell: UICollectionViewCell {

    static let reuseIdentifier = "reviewDescriptionCell"

    private let reviewTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(reviewTextField)

        reviewTextField.snp.makeConstraints { textField in
            textField.edges.equalToSuperview()
        }
    }
}
