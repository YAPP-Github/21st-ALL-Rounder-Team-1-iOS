//
//  MockEntityData.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit

final class MockEntityData {
    static func products() -> [Product] {
        return [
            .init(name: "샴푸", brand: "A", measurement: "g", price: 10, imageURL: "", category: .init(title: "샴푸")),
            .init(name: "스킨", brand: "B", measurement: "g", price: 10, imageURL: "", category: .init(title: "스킨")),
            .init(name: "로션", brand: "C", measurement: "g", price: 10, imageURL: "", category: .init(title: "로션")),
            .init(name: "물", brand: "D", measurement: "g", price: 10, imageURL: "", category: .init(title: "물"))
        ]
    }

    static func stores() -> [Store] {
        return [
            .init(name: "알맹상점", address: "서울시 송파구", distance: 2.5, phoneNumber: "010-1234-5678",
                  snsAddress: "", didUserRecommended: false, recommendedCount: 3,
                  imageURL: [], businessHour: [])
        ]
    }

    static func reviews() -> [Review] {
        return [
            .init(userId: 1, userNickname: "Neph1", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 2, userNickname: "Neph2", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용2",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 3, userNickname: "Neph3", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용3",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 4, userNickname: "Neph4", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 5, userNickname: "Neph5", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용2",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 6, userNickname: "Neph6", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용3",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 7, userNickname: "Neph7", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 8, userNickname: "Neph8", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용2",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 9, userNickname: "Neph9", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용3",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 10, userNickname: "Neph10", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 11, userNickname: "Neph11", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용2",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 12, userNickname: "Neph12", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용3",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
        ]
    }

    static func operations() -> [OperationInfo] {
        return [
        ]
    }

    private init() {}
}
