//
//  Fonts.swift
//  RefillStation
//
//  Created by kong on 2022/11/28.
//

import UIKit

enum TextStyles {
    /// Title
    case titleLarge1
    case titleLarge2
    case titleMedium
    case titleSmall

    /// Body
    case bodyLarge
    case bodyMedium
    case bodySmall

    /// Caption
    case captionLarge
    case captionMedium

    /// Button
    case buttonLarge
    case buttonMedium
    case buttonSmall
}

extension UIFont {
    static func font(style: TextStyles) -> UIFont {
        switch style {
        /// Title
        case .titleLarge1:
            return UIFont.systemFont(ofSize: 22, weight: .bold)
        case .titleLarge2:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        case .titleMedium:
            return UIFont.systemFont(ofSize: 17, weight: .bold)
        case .titleSmall:
            return UIFont.systemFont(ofSize: 15, weight: .bold)

        /// Body
        case .bodyLarge:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .bodyMedium:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .bodySmall:
            return UIFont.systemFont(ofSize: 14, weight: .regular)

        /// Caption
        case .captionLarge:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        case .captionMedium:
            return UIFont.systemFont(ofSize: 11, weight: .medium)

        /// Button
        case .buttonLarge:
            return UIFont.systemFont(ofSize: 15, weight: .semibold)
        case .buttonMedium:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .buttonSmall:
            return UIFont.systemFont(ofSize: 13, weight: .medium)
        }
    }
}
