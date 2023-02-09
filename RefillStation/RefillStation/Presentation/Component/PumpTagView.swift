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

    private let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconArrowRightSmall.image.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        titleLabel.setText(text: level.name, font: .captionLarge)
        disclosureImageView.tintColor = level.labelColor
    }

    func setUpTitle(title: String) {
        disclosureImageView.removeFromSuperview()
        backgroundColor = UserLevelInfo.Level.regular.backgroundColor
        titleLabel.textColor = UserLevelInfo.Level.regular.labelColor
        titleLabel.setText(text: title, font: .captionLarge)
    }

    private func layout() {
        [titleLabel, disclosureImageView].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6).priority(.medium)
        }

        disclosureImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.top.bottom.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(2)
            $0.width.equalTo(disclosureImageView.snp.height)
        }

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
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
