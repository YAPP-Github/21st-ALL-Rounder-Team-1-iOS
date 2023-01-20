//
//  PumpTagView.swift
//  RefillStation
//
//  Created by kong on 2023/01/05.
//

import UIKit
import SnapKit

final class PumpTagView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .captionLarge)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 4
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpTagLevel(level: UserLevelInfo.Level) {
        backgroundColor = level.backgroundColor
        titleLabel.textColor = level.labelColor
        titleLabel.text = level.name
    }

    func setUpTitle(title: String) {
        backgroundColor = UserLevelInfo.Level.regular.backgroundColor
        titleLabel.textColor = UserLevelInfo.Level.regular.labelColor
        titleLabel.text = title
    }

    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(6)
        }
    }
}

fileprivate extension UserLevelInfo.Level {
    var backgroundColor: UIColor {
        switch self {
        case .regular:
            return Asset.Colors.gray1.color
        case .beginner:
            return Asset.Colors.lv1Light.color
        case .prospect:
            return Asset.Colors.lv2Light.color
        case .fancier:
            return Asset.Colors.lv3Light.color
        }
    }

    var labelColor: UIColor {
        switch self {
        case .regular:
            return Asset.Colors.gray5.color
        case .beginner:
            return Asset.Colors.lv1.color
        case .prospect:
            return Asset.Colors.lv2.color
        case .fancier:
            return Asset.Colors.lv3.color
        }
    }
}
