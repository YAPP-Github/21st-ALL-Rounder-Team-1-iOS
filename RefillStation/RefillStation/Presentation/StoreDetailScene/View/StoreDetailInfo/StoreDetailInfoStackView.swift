//
//  StoreInfoStackView.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreDetailInfoStackView: UIStackView {

    weak var delegate: StoreDetailInfoStackViewDelegate?

    // MARK: - UI Components
    private let callButton: UIButton = {
        let button = UIButton()
        button.tintColor = Asset.Colors.gray5.color
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitle("전화", for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .center
        return button
    }()
    private let storeLinkButton: UIButton = {
        let button = UIButton()
        button.tintColor = Asset.Colors.gray5.color
        button.setImage(UIImage(systemName: "link"), for: .normal)
        button.setTitle("매장", for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .center
        return button
    }()
    private let recommendedButton: UIButton = {
        let button = UIButton()
        button.tintColor = Asset.Colors.gray5.color
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.setTitle("추천", for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .center
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
        setUpButtons()
        setButtonActions()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Default Setting Methods
    private func layout() {
        [callButton, storeLinkButton, recommendedButton].forEach {  addArrangedSubview($0) }
    }

    private func setUpButtons() {
        [callButton, storeLinkButton, recommendedButton].forEach { button in
            button.titleLabel?.font = .font(style: .buttomMedium)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        }
    }

    private func setButtonActions() {
        callButton.addAction(UIAction { [weak self] action in
            self?.delegate?.callButtonTapped()
        }, for: .touchUpInside)

        storeLinkButton.addAction(UIAction { [weak self] action in
            self?.delegate?.storeLinkButtonTapped()
        }, for: .touchUpInside)

        recommendedButton.addAction(UIAction { [weak self] action in
            self?.delegate?.recommendButtonTapped()
        }, for: .touchUpInside)
    }
}
