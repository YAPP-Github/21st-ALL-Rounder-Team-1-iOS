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
    private var buttonTitleColor: UIColor {
        switch (style, isEnabled) {
        case (.basic, true):
            return .white
        case (.basic, false):
            return Asset.Colors.gray4.color
        case (.cancel, _):
            return Asset.Colors.gray6.color
        }
    }

    private var buttonBorderColor: CGColor {
        switch style {
        case .basic:
            return UIColor.clear.cgColor
        case .cancel:
            return Asset.Colors.gray3.color.cgColor
        }
    }

    private var buttonBackgroundColor: UIColor {
        switch (style, isEnabled) {
        case (.basic, true):
            return Asset.Colors.primary10.color
        case (.basic, false):
            return Asset.Colors.gray2.color
        case (.cancel, _):
            return .white
        }
    }

    override var isEnabled: Bool {
        didSet {
            setUpButtonColors()
        }
    }

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setUpInitialState()
        setUpButtonColors()
        setUpButtonBorder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpInitialState() {
        self.titleLabel?.font = .font(style: .buttonLarge)
        self.layer.cornerRadius = 8
    }

    private func setUpButtonColors() {
        backgroundColor = buttonBackgroundColor
        setTitleColor(buttonTitleColor, for: state)
    }

    private func setUpButtonBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = buttonBorderColor
    }
}
