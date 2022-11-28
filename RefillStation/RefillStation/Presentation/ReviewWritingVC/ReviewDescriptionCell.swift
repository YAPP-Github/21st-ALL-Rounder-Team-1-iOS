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

    private let placeholder = "다른 손님에게도 도움이 되도록 매장을 이용하며 느꼈던 점을 솔직하게 알려주세요!"
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.textColor = .lightGray
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        textView.font = UIFont.font(style: .bodyMedium)
        return textView
    }()

    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 12)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()

    private let maxTextLabel: UILabel = {
        let label = UILabel()
        label.text = "/500"
        label.font = .systemFont(ofSize: 12)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        setUpReviewTextView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = Asset.Colors.gray2.color.cgColor
        contentView.clipsToBounds = true
    }

    private func setUpReviewTextView() {
        reviewTextView.delegate = self
        reviewTextView.text = placeholder
    }

    private func layout() {
        [reviewTextView, textCountLabel, maxTextLabel].forEach {
            contentView.addSubview($0)
        }

        reviewTextView.snp.makeConstraints { textView in
            textView.leading.top.trailing.equalToSuperview()
        }

        maxTextLabel.snp.makeConstraints { label in
            label.trailing.bottom.equalToSuperview().inset(16)
            label.top.equalTo(reviewTextView.snp.bottom).offset(16)
        }

        textCountLabel.snp.makeConstraints { label in
            label.trailing.equalTo(maxTextLabel.snp.leading)
            label.bottom.equalToSuperview().inset(16)
        }
    }
}

extension ReviewDescriptionCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = Asset.Colors.gray4.color
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        self.textCountLabel.text = "\(textView.text.count)"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text,
              let rangeToChange = Range(range, in: textViewText) else { return false }

        if text == "\n" { textView.resignFirstResponder() }

        let updatedText = textViewText.replacingCharacters(in: rangeToChange, with: text)
        return updatedText.count <= 500
    }
}
