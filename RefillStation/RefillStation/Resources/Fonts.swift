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
    case titleLarge1OverTwoLine
    case titleLarge2
    case titleLarge2OverTwoLine
    case titleMedium
    case titleMediumOverTwoLine
    case titleSmall

    /// Body
    case bodyLarge
    case bodyMedium
    case bodyMediumOverTwoLine
    case bodySmall
    case bodySmallOverTwoLine
    case bodySmallTime

    /// Caption
    case captionLarge
    case captionMedium
    case captionSmall

    /// Button
    case buttonLarge
    case buttonMedium
    case buttonMedium2
    case buttonSmall
}

extension UIFont {
    static func font(style: TextStyles) -> UIFont {
        switch style {
            /// Title
        case .titleLarge1:
            return UIFont.systemFont(ofSize: 22, weight: .bold)
        case .titleLarge1OverTwoLine:
            return UIFont.systemFont(ofSize: 22, weight: .bold)
        case .titleLarge2:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        case .titleLarge2OverTwoLine:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        case .titleMedium:
            return UIFont.systemFont(ofSize: 17, weight: .bold)
        case .titleMediumOverTwoLine:
            return UIFont.systemFont(ofSize: 17, weight: .bold)
        case .titleSmall:
            return UIFont.systemFont(ofSize: 15, weight: .bold)

            /// Body
        case .bodyLarge:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .bodyMedium:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .bodyMediumOverTwoLine:
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        case .bodySmall:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .bodySmallOverTwoLine:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .bodySmallTime:
            return UIFont.systemFont(ofSize: 14, weight: .regular)

            /// Caption
        case .captionLarge:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        case .captionMedium:
            return UIFont.systemFont(ofSize: 11, weight: .medium)
        case .captionSmall:
            return UIFont.systemFont(ofSize: 10, weight: .medium)

            /// Button
        case .buttonLarge:
            return UIFont.systemFont(ofSize: 15, weight: .semibold)
        case .buttonMedium:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .buttonMedium2:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .buttonSmall:
            return UIFont.systemFont(ofSize: 13, weight: .medium)
        }
    }
}

extension TextStyles {
    var lineHeight: CGFloat {
        switch self {
            /// Title
        case .titleLarge1:
            return 24
        case .titleLarge1OverTwoLine:
            return 30
        case .titleLarge2:
            return 22
        case .titleLarge2OverTwoLine:
            return 27
        case .titleMedium:
            return 19
        case .titleMediumOverTwoLine:
            return 23
        case .titleSmall:
            return 17

            /// Body
        case .bodyLarge:
            return 19
        case .bodyMedium:
            return 17
        case .bodyMediumOverTwoLine:
            return 22
        case .bodySmall:
            return 16
        case .bodySmallOverTwoLine:
            return 20
        case .bodySmallTime:
            return 16

            /// Caption
        case .captionLarge:
            return 14
        case .captionMedium:
            return 13
        case .captionSmall:
            return 12

            /// Button
        case .buttonLarge:
            return 17
        case .buttonMedium:
            return 16
        case .buttonMedium2:
            return 16
        case .buttonSmall:
            return 15
        }
    }

    var letterSpacing: CGFloat {
        switch self {
            /// Title
        case .titleLarge1:
            return -0.4
        case .titleLarge1OverTwoLine:
            return -0.4
        case .titleLarge2:
            return -0.4
        case .titleLarge2OverTwoLine:
            return -0.4
        case .titleMedium:
            return -0.4
        case .titleMediumOverTwoLine:
            return -0.4
        case .titleSmall:
            return -0.4

            /// Body
        case .bodyLarge:
            return -0.4
        case .bodyMedium:
            return -0.4
        case .bodyMediumOverTwoLine:
            return -0.4
        case .bodySmall:
            return -0.4
        case .bodySmallOverTwoLine:
            return -0.4
        case .bodySmallTime:
            return -0.8

            /// Caption
        case .captionLarge:
            return -0.4
        case .captionMedium:
            return -0.4
        case .captionSmall:
            return -0.4

            /// Button
        case .buttonLarge:
            return -0.4
        case .buttonMedium:
            return -0.4
        case .buttonMedium2:
            return -1
        case .buttonSmall:
            return -0.4
        }
    }
}
