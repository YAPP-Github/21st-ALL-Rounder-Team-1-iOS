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
        textView.text = "placeholder"
        textView.textColor = .lightGray
        return textView
    }()

    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/500"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpReviewTextView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [reviewTextView, textCountLabel].forEach {
            contentView.addSubview($0)
        }

        reviewTextView.snp.makeConstraints { textView in
            textView.leading.top.trailing.equalToSuperview()
        }

        textCountLabel.snp.makeConstraints { label in
            label.trailing.bottom.equalToSuperview()
            label.top.equalTo(reviewTextView.snp.bottom).offset(5)
        }
    }

    private func setUpReviewTextView() {
        reviewTextView.delegate = self
    }
}

extension ReviewDescriptionCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .label
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "placeholder"
        }
    }
}
