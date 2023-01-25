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
    /// CTAButton Style
    ///
    /// basic - 기본 버튼,
    /// cancel - 팝업에서 사용되는 취소 버튼

    enum Style {
        case basic
        case cancel
    }

    private let style: Style

    override var isEnabled: Bool {
        didSet {
            setUpButtonState()
        }
    }

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setUpInitialState()
        setUpButtonState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpInitialState() {
        self.titleLabel?.font = .font(style: .buttonLarge)
        self.layer.cornerRadius = 8
        switch style {
        case .basic:
            setUpBasicButton()
        case .cancel:
            setUpCancelButton()
        }
    }

    private func setUpBasicButton() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(Asset.Colors.gray4.color, for: .disabled)
    }

    private func setUpCancelButton() {
        self.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        self.backgroundColor = Asset.Colors.gray2.color
    }

    private func setUpButtonState() {
        switch style {
        case .basic:
            self.backgroundColor = isEnabled ? Asset.Colors.primary10.color : Asset.Colors.gray2.color
        case .cancel: // disabled 상태가 없는 버튼
            return
        }
    }
}
