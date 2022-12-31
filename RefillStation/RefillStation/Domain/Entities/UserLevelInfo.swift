//
//  UserLevelInfo.swift
//  RefillStation
//
//  Created by kong on 2022/12/30.
//

import Foundation

struct UserLevelInfo {
    enum Level {
        case regular // 일반 회원
        case beginner // 리필 비기너
        case prospect // 리필 유망주
        case fancier // 리필 애호가
    }
    let level: Level
    let remainCountForNextLevel: Int
}
