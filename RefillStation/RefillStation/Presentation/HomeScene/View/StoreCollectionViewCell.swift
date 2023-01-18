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
    private var storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray1.color
        imageView.contentMode = .scaleAspectFill
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
        label.textColor = Asset.Colors.primary10.color
        return label
    }()

    // MARK: - Initalizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
        render()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Default Setting Methods

    private func layout() {
        [storeImageView, storeInfoView].forEach { contentView.addSubview($0) }
        [nameLabel, addressLabel, distanceLabel].forEach { storeInfoView.addSubview($0) }
        storeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(storeInfoView.snp.top)
        }
        storeInfoView.snp.makeConstraints {
            $0.leading.trailing.equalTo(storeImageView)
            $0.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constraints.labelTopBottomInset)
            $0.leading.trailing.equalToSuperview().inset(Constraints.inset)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(Constraints.inset)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(Constraints.labelTopBottomInset)
            $0.leading.equalToSuperview().inset(Constraints.inset)
        }
    }
    private func render() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray1.color.cgColor
    }

    func setUpImage(image: UIImage) {
        storeImageView.image = image
    }

    func setUpContents(image: String?,
                       name: String,
                       address: String,
                       distance: Double) {
        // set storeImage
        nameLabel.text = name
        addressLabel.text = address
        distanceLabel.text = "\(distance)km"
    }
}

extension StoreCollectionViewCell {
    enum Constraints {
        static let inset: CGFloat = 16
        static let labelTopBottomInset: CGFloat = 20
    }
}
