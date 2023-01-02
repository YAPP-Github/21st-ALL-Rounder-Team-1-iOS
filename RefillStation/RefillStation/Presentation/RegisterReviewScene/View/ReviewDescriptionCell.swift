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
        textView.layer.cornerRadius = 6
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Asset.Colors.gray2.color.cgColor
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
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpReviewTextView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpReviewTextView() {
        reviewTextView.delegate = self
        reviewTextView.text = placeholder
    }

    private func layout() {
        [reviewTextView, dividerView, textCountLabel, maxTextLabel].forEach { contentView.addSubview($0) }
        reviewTextView.snp.makeConstraints { textView in
            textView.top.equalToSuperview()
            textView.leading.trailing.equalToSuperview().inset(16)
        }

        maxTextLabel.snp.makeConstraints { label in
            label.trailing.bottom.equalTo(reviewTextView).inset(16)
        }

        textCountLabel.snp.makeConstraints { label in
            label.trailing.equalTo(maxTextLabel.snp.leading)
            label.centerY.equalTo(maxTextLabel)
        }

        dividerView.snp.makeConstraints { view in
            view.height.equalTo(1)
            view.top.equalTo(reviewTextView.snp.bottom).offset(20)
            view.leading.trailing.bottom.equalToSuperview()
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

        let updatedText = textViewText.replacingCharacters(in: rangeToChange, with: text)
        return updatedText.count <= 500
    }
}
