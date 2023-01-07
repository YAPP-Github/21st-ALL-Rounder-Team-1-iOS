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
        label.textColor = Asset.Colors.gray5.color
        label.font = .font(style: .captionLarge)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Asset.Colors.gray1.color
        self.layer.cornerRadius = 4
        layout()

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(6)
        }
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
