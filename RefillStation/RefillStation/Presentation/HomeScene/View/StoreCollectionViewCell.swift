//
//  StoreCollectionViewCell.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit
import SnapKit

final class StoreCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "StoreCollectionViewCell"

    // MARK: - UI Components
    private var storeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray1.color
        return imageView
    }()
    private var storeInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleMedium)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .bodySmall)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .buttonLarge)
        label.textColor = Asset.Colors.primary3.color
        return label
    }()
    private var firstDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray2.color
        return view
    }()
    private var openStateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private var secondDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray2.color
        return view
    }()
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    // MARK: - Initalizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        render()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Default Setting Methods

    private func layout() {
        [storeImage, storeInfoView].forEach { contentView.addSubview($0) }
        [nameLabel, addressLabel, distanceLabel, firstDividerView,
         openStateLabel, secondDividerView, timeLabel].forEach { storeInfoView.addSubview($0) }

        storeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(storeInfoView.snp.top)
        }
        storeInfoView.snp.makeConstraints {
            $0.height.equalTo(107)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
        }
        firstDividerView.snp.makeConstraints {
            $0.centerY.equalTo(distanceLabel)
            $0.leading.equalTo(distanceLabel.snp.trailing).offset(6)
            $0.width.equalTo(1)
            $0.height.equalTo(11)
        }
        openStateLabel.snp.makeConstraints {
            $0.centerY.equalTo(firstDividerView)
            $0.leading.equalTo(firstDividerView.snp.trailing).offset(6)
        }
        secondDividerView.snp.makeConstraints {
            $0.centerY.equalTo(openStateLabel)
            $0.leading.equalTo(openStateLabel.snp.trailing).offset(6)
            $0.width.equalTo(1)
            $0.height.equalTo(11)
        }
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(secondDividerView)
            $0.leading.equalTo(secondDividerView.snp.trailing).offset(6)
        }
    }
    private func render() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray1.color.cgColor
    }

    func setUpContents(image: String?,
                       name: String,
                       address: String,
                       distance: Double,
                       openState: Bool,
                       time: String) {
        // set storeImage
        nameLabel.text = name
        addressLabel.text = address
        distanceLabel.text = "\(distance)km"
        openStateLabel.text = openState ? "영업중" : "영업 종료"
        timeLabel.text = time
    }
}
