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
    var moveToRegionRequest: (() -> Void)?

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
        label.text = "서울 마포구 월드컵로 212"
        return label
    }()
    private let guidanceLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 위치하고 계신 곳은\n아직 서비스 지역이 아니에요😭"
        label.font = .font(style: .titleMedium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.imgServiceArea.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스 지역 신청하러 가기", for: .normal)
        button.backgroundColor = Asset.Colors.primary3.color
        button.setTitleColor(Asset.Colors.primary10.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.addTarget(self, action: #selector(requestButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 지역 매장 둘러보기"
        label.font = .font(style: .titleMedium)
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
    private func layout() {
        [locationIcon, currentLocationLabel, guidanceLabel,
         imageView, requestButton, dividerView, headerTitleLabel].forEach { addSubview($0) }
        locationIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(66)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        currentLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIcon.snp.trailing).offset(6)
            $0.centerY.equalTo(locationIcon)
        }
        guidanceLabel.snp.makeConstraints {
            $0.top.equalTo(locationIcon.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(guidanceLabel.snp.bottom).offset(8)
            $0.height.equalTo(134)
            $0.centerX.equalToSuperview()
        }
        requestButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(48)
            $0.height.equalTo(40)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(requestButton.snp.bottom).offset(20)
            $0.height.equalTo(8)
            $0.leading.trailing.equalToSuperview()
        }
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Function
    @objc private func requestButtonDidTap() {
        moveToRegionRequest?()
    }
}
