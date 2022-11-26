//
//  ReviewDescriptionCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewDescriptionCell: UICollectionViewCell {

    static let reuseIdentifier = "reviewDescriptionCell"

    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(reviewTextView)

        reviewTextView.snp.makeConstraints { textView in
            textView.edges.equalToSuperview()
        }
    }
}
