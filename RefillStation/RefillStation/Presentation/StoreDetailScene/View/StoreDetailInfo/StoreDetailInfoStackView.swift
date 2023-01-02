//
//  StoreInfoStackView.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreDetailInfoStackView: UIStackView {

    // MARK: - UI Components
    private var callButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconCall.image, for: .normal)
        button.setTitle("전화", for: .normal)
        return button
    }()
    private var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconSns.image, for: .normal)
        button.setTitle("SNS", for: .normal)
        return button
    }()
    private var directionButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconDirection.image, for: .normal)
        button.setTitle("길찾기", for: .normal)
        return button
    }()
    private var recommendedButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconThumbsup.image, for: .normal)
        button.setTitle("추천해요", for: .normal)
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
        setUpButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Default Setting Methods
    private func layout() {
        [callButton, instagramButton, directionButton, recommendedButton].forEach {  addArrangedSubview($0) }
    }

    private func setUpButtons() {
        [callButton, instagramButton, directionButton, recommendedButton].forEach { button in
            button.titleLabel?.font = .font(style: .buttonMedium)
            guard let image = button.imageView?.image else { return }
            guard let titleLabel = button.titleLabel else { return }
            guard let titleText = titleLabel.text else { return }
            let titleSize = titleText.size(withAttributes: [
                NSAttributedString.Key.font: titleLabel.font as Any
            ])
            button.titleEdgeInsets = UIEdgeInsets(top: 5,
                                                  left: -image.size.width,
                                                  bottom: -image.size.height,
                                                  right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + 5),
                                                  left: 0,
                                                  bottom: 0,
                                                  right: -titleSize.width)
            button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        }
    }
}
