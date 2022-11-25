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
        button.backgroundColor = .darkGray
        return button
    }()
    private var instagramButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        return button
    }()
    private var recommendedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Default Setting Methods
    private func setUpConstraints() {
        [callButton, instagramButton, recommendedButton].forEach { addArrangedSubview($0) }
        [callButton, instagramButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.25)
            }
        }
    }
}
