//
//  PumpLargeTitleNavigationBar.swift
//  RefillStation
//
//  Created by kong on 2023/01/12.
//

import UIKit
import SnapKit

final class PumpLargeTitleNavigationBar: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleLarge2)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [titleLabel, dividerView].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setNavigationTitle(_ title: String) {
        titleLabel.text = title
    }
}
