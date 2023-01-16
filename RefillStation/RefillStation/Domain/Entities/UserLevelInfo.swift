//
//  UserLevelInfo.swift
//  RefillStation
//
//  Created by kong on 2022/12/30.
//

import Foundation

struct UserLevelInfo {
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
    }
    let level: Level
    let remainCountForNextLevel: Int
}
