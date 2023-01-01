//
//  StoreDetailInfoView.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreDetailInfoView: UIView {

    // MARK: - UI Components
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let storeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private let checkRefillGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "리필가이드 확인하기"
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private let moveToRefillGuideButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 12))
        let image = UIImage(systemName: "chevron.forward", withConfiguration: imageConfiguration)
        button.tintColor = Asset.Colors.gray5.color
        button.setImage(image, for: .normal)
        return button
    }()
    private let storeStackOuterView: UIView = { // StackView에는 cornerRadius적용이 불가하기 때문에 감싸는 View를 제작
        let outerView = UIView()
        outerView.layer.borderColor = Asset.Colors.gray1.color.cgColor
        outerView.layer.borderWidth = 1
        outerView.layer.cornerRadius = 4
        outerView.clipsToBounds = true
        return outerView
    }()
    private let storeInfoStackView: StoreDetailInfoStackView = {
        let stackView = StoreDetailInfoStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = Asset.Colors.gray1.color
        stackView.spacing = 1
        return stackView
    }()
    private let bottomDivisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    // MARK: - Properties
    private var viewModel: StoreDetailInfoViewModel

    // MARK: - Initialization
    init(viewModel: StoreDetailInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white
        bind()
        layout()
        render()
    }

    required init?(coder: NSCoder) {
        self.viewModel = StoreDetailInfoViewModel()
        super.init(coder: coder)
    }

    // MARK: - Default Setting Methods
    private func bind() {
        storeNameLabel.text = viewModel.name
        storeAddressLabel.text = viewModel.address
    }

    private func layout() {
        [storeNameLabel, checkRefillGuideLabel, storeAddressLabel, moveToRefillGuideButton, storeStackOuterView, bottomDivisionLine].forEach { addSubview($0) }
        storeStackOuterView.addSubview(storeInfoStackView)

        storeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        checkRefillGuideLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(16)
        }
        moveToRefillGuideButton.snp.makeConstraints {
            $0.leading.equalTo(checkRefillGuideLabel.snp.trailing).offset(6)
            $0.top.bottom.equalTo(checkRefillGuideLabel)
        }
        storeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(checkRefillGuideLabel.snp.bottom).offset(10)
            $0.leading.equalTo(storeNameLabel)
        }
        storeStackOuterView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.top.equalTo(storeAddressLabel.snp.bottom).offset(5)
        }
        storeInfoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(12)
        }
        bottomDivisionLine.snp.makeConstraints {
            $0.top.equalTo(storeStackOuterView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func render() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
}
