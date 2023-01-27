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
        ]
    }

    static func stores() -> [Store] {
        return [
            Store(name: "알맹상점", address: "경기도 용인시 수지구 동천로", distance: 2.56,
                  phoneNumber: "031-1588-1588", snsAddress: "www.naver.com", didUserRecommended: true,
                  recommendedCount: 10, imageURL: [""],
                  businessHour: .init(day: .mon, time: ""))
        ]
    }

    static func reviews() -> [Review] {
        return [
            Review(userId: 1, userNickname: "Neph", profileImagePath: "",
                   writtenDate: Date(), imageURL: [""], description: "내용",
                   tags: [.init(id: 1, image: UIImage(systemName: "person")!, title: "태그 태그")])
        ]
    }

    static func tags() -> [Tag] {
        return [
        ]
    }

    static func operations() -> [OperationInfo] {
        return [
        ]
    }

    private init() {}
}
