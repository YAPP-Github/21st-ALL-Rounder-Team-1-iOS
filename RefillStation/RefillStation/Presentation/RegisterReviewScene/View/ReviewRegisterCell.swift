//
//  reviewRegisterCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/27.
//

import UIKit
import SnapKit

final class ReviewRegisterCell: UICollectionViewCell {

    static let reuseIdentifier = "reviewRegisterCell"

    private let registerButton: CTAButton = {
        let button = CTAButton()
        button.setTitle("등록하기", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(registerButton)
        registerButton.snp.makeConstraints { button in
            button.edges.equalToSuperview()
        }
    }
}
