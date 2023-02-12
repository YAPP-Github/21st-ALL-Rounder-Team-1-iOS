//
//  UILabelExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/09.
//

import UIKit

extension UILabel {
    func setText(text: String?, font: TextStyles) {
        self.text = text
        self.font = .font(style: font)
        setLineLetterSpacing(font: font)
    }
    func setLineLetterSpacing(font: TextStyles) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = font.lineHeight
            style.minimumLineHeight = font.lineHeight

            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (font.lineHeight - self.font.lineHeight) / 4,
                .kern: font.letterSpacing
            ]

            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
