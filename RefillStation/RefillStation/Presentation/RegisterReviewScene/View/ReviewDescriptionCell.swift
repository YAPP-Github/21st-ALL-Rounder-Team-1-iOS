//
//  ReviewDescriptionCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewDescriptionCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ReviewDescriptionCell.self)
    var didChangeText: ((String) -> Void)?

    private let placeholder = "다른 손님에게도 도움이 되도록 매장을 이용하며 느꼈던 점을 솔직하게 알려주세요!"

    private let outerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = Asset.Colors.gray2.color.cgColor
        return view
    }()
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.textColor = Asset.Colors.gray4.color
        textView.font = UIFont.font(style: .bodyMediumOverTwoLine)
        textView.tintColor = Asset.Colors.primary10.color
        return textView
    }()

    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "0", font: .captionLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()

    private let maxTextLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "/500", font: .captionLarge)
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
        contentView.backgroundColor = .white
        setUpReviewTextView()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpReviewTextView() {
        reviewTextView.delegate = self
        reviewTextView.text = placeholder
        reviewTextView.setText(text: placeholder, font: .bodyMediumOverTwoLine, textColor: Asset.Colors.gray4.color)
    }

    private func layout() {
        [outerView, reviewTextView, textCountLabel, maxTextLabel].forEach { contentView.addSubview($0) }
        outerView.snp.makeConstraints { textView in
            textView.top.equalToSuperview().inset(7)
            textView.leading.trailing.equalToSuperview().inset(16)
            textView.bottom.equalToSuperview().inset(20)
        }

        reviewTextView.snp.makeConstraints { textView in
            textView.top.leading.trailing.equalTo(outerView).inset(16)
            textView.bottom.equalTo(maxTextLabel.snp.top).offset(-12)
        }

        maxTextLabel.snp.makeConstraints { label in
            label.trailing.bottom.equalTo(outerView).inset(16)
        }

        textCountLabel.snp.makeConstraints { label in
            label.trailing.equalTo(maxTextLabel.snp.leading)
            label.centerY.equalTo(maxTextLabel)
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
        self.textCountLabel.setText(text: "\(textView.text.count)", font: .captionLarge)
        textView.setText(text: textView.text, font: .bodyMediumOverTwoLine, textColor: Asset.Colors.gray7.color)
        didChangeText?(textView.text)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text,
              let rangeToChange = Range(range, in: textViewText) else { return false }

        let updatedText = textViewText.replacingCharacters(in: rangeToChange, with: text)
        return updatedText.count <= 500
    }
}
