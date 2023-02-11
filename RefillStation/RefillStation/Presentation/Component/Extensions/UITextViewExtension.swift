//
//  UITextViewExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/10.
//

import UIKit

extension UITextView {
    func setText(text: String?, font: TextStyles, textColor: UIColor) {
        self.text = text
        self.font = .font(style: font)
        setLineLetterSpacing(font: font, textColor: textColor)
    }
    func setLineLetterSpacing(font: TextStyles, textColor: UIColor) {
        if let text = text, let textViewFont = self.font {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = font.lineHeight
            style.minimumLineHeight = font.lineHeight

            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (font.lineHeight - textViewFont.lineHeight) / 4,
                .kern: font.letterSpacing,
                .font: UIFont.font(style: font),
                .foregroundColor: textColor
            ]

            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
