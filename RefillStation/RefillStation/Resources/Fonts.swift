//
//  Fonts.swift
//  RefillStation
//
//  Created by kong on 2022/11/28.
//

import UIKit

enum TextStyles {
    case titleLarge
    case titleMedium
    case titleSmall
    case bodyLarge
    case bodyMedium
    case bodySmall
    case buttonLarge
    case buttomMedium
    case captionLarge
    case captionMedium
}

extension UIFont {
    static func font(style: TextStyles) -> UIFont {
        switch style {
        case .titleLarge:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        case .titleMedium:
            return UIFont.systemFont(ofSize: 17, weight: .bold)
        case .titleSmall:
            return UIFont.systemFont(ofSize: 15, weight: .bold)
        case .bodyLarge:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .bodyMedium:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .bodySmall:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .buttonLarge:
            return UIFont.systemFont(ofSize: 15, weight: .semibold)
        case .buttomMedium:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .captionLarge:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        case .captionMedium:
            return UIFont.systemFont(ofSize: 11, weight: .medium)
        }
    }
}
