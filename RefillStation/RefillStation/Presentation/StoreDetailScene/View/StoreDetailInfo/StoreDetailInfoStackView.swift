//
//  StoreInfoStackView.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit
import SnapKit

// MARK: - StoreButton
final class StoreButton: UIButton {
    let type: StoreDetailViewModel.StoreInfoButtonType
    init(type: StoreDetailViewModel.StoreInfoButtonType) {
        self.type = type
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - StoreDetailInfoStackView
final class StoreDetailInfoStackView: UIStackView {

    let callButton = StoreButton(type: .phone)
    let storeLinkButton = StoreButton(type: .phone)
    let recommendedButton = StoreButton(type: .phone)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
        setUpButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [callButton, storeLinkButton, recommendedButton].forEach { addArrangedSubview($0) }
    }

    private func setUpButtons() {
        [callButton, storeLinkButton, recommendedButton].forEach { button in
            button.titleLabel?.font = .font(style: .buttonMedium)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
            button.tintColor = Asset.Colors.gray5.color
            button.setImage(button.type.image, for: .normal)
            button.setTitle(button.type.title, for: .normal)
            button.backgroundColor = .white
            button.contentHorizontalAlignment = .center
        }
    }
}
