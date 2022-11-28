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
                contentView.backgroundColor = .white
                contentView.layer.borderColor = Asset.Colors.primary3.color.cgColor
                tagTitleLabel.textColor = Asset.Colors.primary3.color
            } else {
                contentView.backgroundColor = Asset.Colors.gray1.color
                contentView.layer.borderColor = Asset.Colors.gray1.color.cgColor
                tagTitleLabel.textColor = Asset.Colors.gray5.color
            }
        }
    }

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

    func setUpContents(title: String) {
        tagTitleLabel.text = title
    }

    private func setUpContentView() {
        contentView.backgroundColor = Asset.Colors.gray1.color
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray1.color.cgColor
    }

    private func layout() {
        contentView.addSubview(tagTitleLabel)
        tagTitleLabel.snp.makeConstraints { tag in
            tag.edges.equalTo(contentView).inset(5)
        }
    }
}
