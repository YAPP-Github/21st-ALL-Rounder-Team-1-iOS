//
//  UserLevelInfo.swift
//  RefillStation
//
//  Created by kong on 2022/12/30.
//

import UIKit

struct UserLevelInfo: Hashable {
    enum Level: CaseIterable {
        case regular
        case beginner
        case prospect
        case fancier
        var name: String {
            switch self {
            case .regular:
                return "일반 회원"
            case .beginner:
                return "리필 비기너"
            case .prospect:
                return "리필 유망주"
            case .fancier:
                return "리필 애호가"
            }
        }
        var levelUpTriggerCount: Int {
            switch self {
            case .regular:
                return 0
            case .beginner:
                return 1
            case .prospect:
                return 3
            case .fancier:
                return 5
            }
        }
        var levelTagText: String {
            switch self {
            case .regular:
                return "리뷰 0회"
            case .beginner:
                return "리뷰 1회 이상"
            case .prospect:
                return "리뷰 3회 이상"
            case .fancier:
                return "리뷰 5회 이상"
            }
        }
        var color: UIColor {
            switch self {
            case .regular:
                return Asset.Colors.gray6.color
            case .beginner:
                return Asset.Colors.lv1.color
            case .prospect:
                return Asset.Colors.lv2.color
            case .fancier:
                return Asset.Colors.lv3.color
            }
        }
    }
    let level: Level
    let remainCountForNextLevel: Int
}
