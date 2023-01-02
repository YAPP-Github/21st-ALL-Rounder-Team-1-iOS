//
//  CTAButton.swift
//  RefillStation
//
//  Created by kong on 2023/01/01.
//

import UIKit

/// isEnabled, disabled 두 가지 상태를 가진 공통 CTAButton 컴포넌트입니다.
/// setTitle을 통해 버튼 타이틀을 변경해서 사용합니다.
final class CTAButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            setUpButtonState()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpInitialState()
        setUpButtonState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpInitialState() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(Asset.Colors.gray4.color, for: .disabled)
        self.titleLabel?.font = .font(style: .buttonLarge)
        self.layer.cornerRadius = 8
    }

    private func setUpButtonState() {
        if isEnabled {
            self.backgroundColor = Asset.Colors.primary3.color
        } else {
            self.backgroundColor = Asset.Colors.gray2.color
        }
    }
}
