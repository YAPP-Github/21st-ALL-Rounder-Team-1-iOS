//
//  TagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class TagReviewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: TagReviewCell.self)
    override var isSelected: Bool {
        didSet {
            isSelected ? setUpSelectedButton() : setUpUnselectedButton()
        }
    }

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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

    func setUpUnselectedButton() {
        contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
        contentView.backgroundColor = .white
        tagTitleLabel.textColor = Asset.Colors.gray5.color
    }

    func setUpDisabledButton() {
        contentView.backgroundColor = Asset.Colors.gray1.color
        contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
        tagTitleLabel.textColor = Asset.Colors.gray3.color
    }

    private func setUpContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 22
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
    }

    private func setUpSelectedButton() {
        contentView.backgroundColor = Asset.Colors.primary1.color
        contentView.layer.borderColor = Asset.Colors.primary10.color.cgColor
        tagTitleLabel.textColor = Asset.Colors.primary10.color
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
