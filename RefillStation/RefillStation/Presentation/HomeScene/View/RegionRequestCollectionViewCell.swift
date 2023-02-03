//
//  RegionRequestCollectionViewCell.swift
//  RefillStation
//
//  Created by kong on 2023/02/04.
//

import UIKit
import SnapKit

class RegionRequestCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: RegionRequestCollectionViewCell.self)
    var moveToRegionRequest: (() -> Void)?

    private let registerRegionView: UIView = {
        let view = UIView()
        return view
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

    // MARK: - Initalizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [guidanceLabel, imageView, requestButton,
         dividerView, headerTitleLabel].forEach { contentView.addSubview($0) }
        guidanceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
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
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    @objc private func requestButtonDidTap() {
        moveToRegionRequest?()
    }
}
