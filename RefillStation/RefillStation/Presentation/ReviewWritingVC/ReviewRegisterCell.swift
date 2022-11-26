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

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        contentView.addSubview(registerButton)
        registerButton.snp.makeConstraints { button in
            button.edges.equalToSuperview()
        }
    }
}
