//
//  ApplyForRegionHeaderView.swift
//  RefillStation
//
//  Created by kong on 2022/12/03.
//

import UIKit
import SnapKit

final class ApplyForRegionHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "ApplyForRegionHeaderView"

    // MARK: - UIComponents
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
        imageView.image = Asset.Images.regionImage.image
        return imageView
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스 지역 신청하러 가기", for: .normal)
        button.backgroundColor = Asset.Colors.primary1.color
        button.setTitleColor(Asset.Colors.primary3.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.addTarget(self, action: #selector(applyButtonDidTap), for: .touchUpInside)
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
        render()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Default Setting Methods
    private func layout() {
        [guidanceLabel, imageView, applyButton, dividerView, headerTitleLabel].forEach { addSubview($0) }
        guidanceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(imageView.snp.top).offset(8)
        }
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(applyButton.snp.top).inset(6)
        }
        applyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(48)
            $0.height.equalTo(40)
            $0.bottom.equalTo(dividerView.snp.top).inset(-20)
        }
        dividerView.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.leading.trailing.equalToSuperview()
        }
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    private func render() {
        applyButton.layer.cornerRadius = 6
    }

    // MARK: - Function
    @objc private func applyButtonDidTap() {
        print("applyButtonDidTap")
    }
}
