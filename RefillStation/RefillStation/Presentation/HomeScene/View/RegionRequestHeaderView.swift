//
//  RegionRequestHeaderView.swift
//  RefillStation
//
//  Created by kong on 2022/12/03.
//

import UIKit
import SnapKit

final class RegionRequestHeaderView: UICollectionReusableView {

    static let reuseIdentifier = String(describing: RegionRequestHeaderView.self)

    // MARK: - UIComponents

    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconPosition.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let currentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .captionLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Default Setting Methods
    func setUpView(address: String) {
        currentLocationLabel.setText(text: address, font: .captionLarge)
    }
    private func layout() {
        [locationIcon, currentLocationLabel].forEach { addSubview($0) }
        locationIcon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        currentLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIcon.snp.trailing).offset(6)
            $0.centerY.equalTo(locationIcon)
        }
    }
}
