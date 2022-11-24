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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private var storeAddressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var openStateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private var closeTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var mapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    private var distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var storeInfoStackView: StoreDetailInfoStackView = {
        let stackView = StoreDetailInfoStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: - Properties
    private var viewModel: StoreDetailViewModel

    // MARK: - Initialization
    init(viewModel: StoreDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        bind()
        setUpConstraints()
        render()
    }

    required init?(coder: NSCoder) {
        self.viewModel = StoreDetailViewModel()
        super.init(coder: coder)
    }

    // MARK: - Default Setting Methods
    private func bind() {
        storeNameLabel.text = viewModel.name
        storeAddressLabel.text = viewModel.address
        openStateLabel.text = viewModel.openState ? "영업중" : "휴무"
        closeTimeLabel.text = viewModel.closeTime
        distanceLabel.text = "\(viewModel.distance)km"
    }

    private func setUpConstraints() {
        addSubviews(storeNameLabel, storeAddressLabel, openStateLabel, separatorLine,
                    closeTimeLabel, mapButton, distanceLabel, storeInfoStackView)
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
        mapButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(44)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(mapButton.snp.bottom).offset(10)
            $0.centerX.equalTo(mapButton)
        }
        storeInfoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

    private func render() {
        mapButton.makeRounded(radius: 22)
        storeInfoStackView.makeRounded(radius: 10)
    }
}
