//
//  MockEntityData.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit
import Algorithms

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
        let didUserRecommended = false
        let isRecommendCountOverZero = false
        let checkLists = [didUserRecommended, isRecommendCountOverZero]
        var stores = [Store]()
        for combo in (checkLists.startIndex..<checkLists.endIndex).map({ $0 }).combinations(ofCount: checkLists.startIndex..<checkLists.endIndex) {
            var temporaryCheckLists = checkLists
            combo.forEach { temporaryCheckLists[$0] = true }
            stores.append(store(didUserRecommended: temporaryCheckLists[0],
                                isRecommendCountOverZero: temporaryCheckLists[1],
                                isSNSAddressExists: false))
        }
        stores.append(store(didUserRecommended: true,
                            isRecommendCountOverZero: true,
                            isSNSAddressExists: true))

        return stores
    }

    static func reviews() -> [Review] {
        return [
            .init(userId: 1, userNickname: "Neph1", profileImagePath: "",
                  writtenDate: Date(), imageURL: ["", "", ""], description: "내용",
                  tags: [.storeIsBig]),
            .init(userId: 2, userNickname: "Neph2", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용은 있어요",
                  tags: []),
            .init(userId: 3, userNickname: "Neph3", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용3",
                  tags: []),
            .init(userId: 4, userNickname: "Neph4", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
            .init(userId: 5, userNickname: "Neph5", profileImagePath: "",
                  writtenDate: Date(), imageURL: [], description: "내용2",
                  tags: [.clerkIsKind, .canEarnPoint, .storeIsBig]),
        ]
    }
    private init() {}

    static func store(didUserRecommended: Bool, isRecommendCountOverZero: Bool, isSNSAddressExists: Bool) -> Store {
        return Store(name: "유저추천: \(didUserRecommended ? "O" : "X"), 추천수: \(isRecommendCountOverZero ? "10" : "0"), sns: \(isSNSAddressExists ? "있음" : "없음")", address: "서울시 송파구 오금로", distance: 2.5,
                     phoneNumber: "010-1234-5678", snsAddress: isSNSAddressExists ? "https://www.naver.com" : "",
                     didUserRecommended: didUserRecommended, recommendedCount: isRecommendCountOverZero ? 10 : 0,
                     imageURL: [""], businessHour: [
                        .init(day: .mon, time: "10:00 - 18:00"),
                        .init(day: .tue, time: "10:00 - 18:00"),
                        .init(day: .wed, time: "10:00 - 18:00"),
                        .init(day: .thu, time: "10:00 - 18:00"),
                        .init(day: .fri, time: "10:00 - 18:00"),
                        .init(day: .sat, time: "10:00 - 18:00"),
                        .init(day: .sun, time: nil)]
                     , notice: "")
    }
}
