//
//  TagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class TagReviewCell: UICollectionViewCell {

    static let reuseIdentifier = "tagCollectionViewCell"

    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = Asset.Colors.primary0.color
                contentView.layer.borderColor = Asset.Colors.primary3.color.cgColor
                tagTitleLabel.textColor = Asset.Colors.primary3.color
            } else {
                contentView.backgroundColor = .white
                contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
                tagTitleLabel.textColor = Asset.Colors.gray5.color
            }
        }
    }

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Asset.Colors.gray2.color
        return imageView
    }()

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(image: UIImage, title: String) {
        tagImageView.image = image
        tagTitleLabel.text = title
    }

    private func setUpContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
    }

    private func layout() {
        [tagImageView, tagTitleLabel].forEach { contentView.addSubview($0) }
        tagImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.width.equalTo(tagImageView.snp.height)
            $0.leading.equalToSuperview().inset(15)
        }
        tagTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.equalTo(tagImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
