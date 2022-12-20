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
    private var storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private var storeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private var openStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private var closeTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()
    private var storeInfoStackView: StoreDetailInfoStackView = {
        let stackView = StoreDetailInfoStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var refillGuideButton: UIView = {
        let view = UIView()
        return view
    }()
    private var refillGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "방문 전 리필 가이드를 확인해보세요!"
        label.textColor = Asset.Colors.gray5.color
        label.font = .font(style: .bodyMedium)
        return label
    }()
    private var refillGuideArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconArrowRightSmall.image
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        openStateLabel.text = viewModel.openState ? "영업중" : "휴무"
        closeTimeLabel.text = viewModel.closeTime
    }

    private func layout() {
        [storeNameLabel, storeAddressLabel, openStateLabel, separatorLine,
         closeTimeLabel, dividerView, storeInfoStackView, refillGuideButton].forEach { addSubview($0) }
        [refillGuideLabel, refillGuideArrowImageView].forEach { refillGuideButton.addSubview($0) }

        storeNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        storeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(storeNameLabel)
        }
        openStateLabel.snp.makeConstraints {
            $0.top.equalTo(storeAddressLabel.snp.bottom).offset(10)
            $0.leading.equalTo(storeAddressLabel)
        }
        separatorLine.snp.makeConstraints {
            $0.top.bottom.equalTo(openStateLabel)
            $0.leading.equalTo(openStateLabel.snp.trailing).offset(10)
            $0.width.equalTo(1)
        }
        closeTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(openStateLabel)
            $0.leading.equalTo(separatorLine.snp.trailing).offset(10)
        }
        dividerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(storeInfoStackView).inset(-1)
        }
        storeInfoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
            $0.top.equalTo(closeTimeLabel.snp.bottom).offset(5)
        }

        refillGuideButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(dividerView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(54)
        }
        refillGuideLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        refillGuideArrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }

    private func render() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
}
