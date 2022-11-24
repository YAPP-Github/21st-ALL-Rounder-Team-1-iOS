//
//  TagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class TagCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "tagCollectionViewCell"

    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .lightGray
            } else {
                contentView.backgroundColor = .white
            }
        }
    }

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeContentViewLayer()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(title: String) {
        tagTitleLabel.text = title
    }

    private func makeContentViewLayer() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
    }

    private func layout() {
        contentView.addSubview(tagTitleLabel)
        tagTitleLabel.snp.makeConstraints { tag in
            tag.edges.equalTo(contentView).inset(5)
        }
    }
}
