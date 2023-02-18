//
//  MockEntityData.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit
import Algorithms

final class MockEntityData {

    private init() {}

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
        let isSNSAddressExists = false
        let checkLists = [didUserRecommended, isRecommendCountOverZero]
        var stores = [Store?]()
        for combo in (checkLists.startIndex..<checkLists.endIndex).map({ $0 }).combinations(ofCount: checkLists.startIndex..<checkLists.endIndex) {
            var temporaryCheckLists = checkLists
            combo.forEach { temporaryCheckLists[$0] = true }
            stores.append(store(checkLists: temporaryCheckLists + [false]))
        }
        stores.append(store(checkLists: [false, false, true]))

        return stores.compactMap { $0 }
    }

    static func reviews() -> [Review] {
        let hasImage = false
        let isImageOverOne = false
        let hasTag = false
        let isTagOverTwo = false
        let hasDescription = false
        let hasLongDescription = false
        let checkLists = [hasImage, isImageOverOne, hasTag, isTagOverTwo, hasDescription, hasLongDescription]
        var reviews = [Review?]()
        for combo in (checkLists.startIndex..<checkLists.endIndex).map({ $0 }).combinations(ofCount: checkLists.startIndex..<checkLists.endIndex) {
            var temporaryCheckLists = checkLists
            combo.forEach { temporaryCheckLists[$0] = true }
            reviews.append(review(chekLists: temporaryCheckLists))
        }
        return reviews.compactMap { $0 }
    }

    static func store(checkLists: [Bool]) -> Store? {
        let didUserRecommended = checkLists[0]
        let isRecommendCountOverZero = checkLists[1]
        let isSNSAddressExists = checkLists[2]

        if didUserRecommended && isRecommendCountOverZero { return nil }
        return Store(storeId: 1, name: "유저추천: \(didUserRecommended ? "O" : "X"), 추천수: \(isRecommendCountOverZero ? "10" : "0"), sns: \(isSNSAddressExists ? "있음" : "없음")", address: "서울시 송파구 오금로", distance: 2.5,
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
                     , notice: "", storeRefillGuideImagePaths: [])
    }

    static func review(chekLists: [Bool]) -> Review? {
        let hasImage = chekLists[0]
        let isImageOverOne = chekLists[1]
        let hasTag = chekLists[2]
        let isTagOverTwo = chekLists[3]
        let hasDescription = chekLists[4]
        let hasLongDescription = chekLists[5]
        if (!hasImage && !hasTag && !hasDescription) || (!hasImage && isImageOverOne) || (!hasTag && isTagOverTwo) || (!hasDescription && hasLongDescription) {
            return nil
        }

        let imagePaths = Array(repeating: "", count: isImageOverOne ? 3 : (hasImage ? 1 : 0))
        let tags = Tag.allCases.filter({ $0 != .noKeywordToChoose })
            .randomSample(count: isTagOverTwo ? 3 : (hasTag ? 1 : 0))
        let shortDescription = "좋은 매장이었습니다."
        let longDescription = (0...20).reduce(into: "") { partialResult, _ in
            partialResult += "좋은 매장이었습니다."
        }
        let description = hasLongDescription ? longDescription : (hasDescription ? shortDescription : "")
        let descriptionType = hasLongDescription ? "김" : (hasDescription ? "짧음" : "없음" )

        return Review(userId: 1, userNickname: "이미지수: \(imagePaths.count), 태그수: \(tags.count), 내용: \(descriptionType)",
                      profileImagePath: "", writtenDate: Date(),
                      imageURL: imagePaths, description: description, tags: tags)
    }
}
