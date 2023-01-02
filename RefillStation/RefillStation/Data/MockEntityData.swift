//
//  MockEntityData.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit

final class MockEntityData {
    static func products() -> [Product] {
        return []
    }

    static func stores() -> [Store] {
        return [
            .init(name: "지구샵 제로웨이스트홈",
                  address: "서울 마포구 성미산로 155 1층",
                  distance: 30,
                  phoneNumber: "01012345678",
                  snsAddress: "",
                  didUserRecommended: true,
                  recommendedCount: 10,
                  thumbnailImageURL: "",
                  imageURL: []),
            .init(name: "지구샵 제로웨이스트홈",
                  address: "서울 마포구 성미산로 155 1층",
                  distance: 30,
                  phoneNumber: "01012345678",
                  snsAddress: "",
                  didUserRecommended: true,
                  recommendedCount: 10,
                  thumbnailImageURL: "",
                  imageURL: []),
            .init(name: "지구샵 제로웨이스트홈",
                  address: "서울 마포구 성미산로 155 1층",
                  distance: 30,
                  phoneNumber: "01012345678",
                  snsAddress: "",
                  didUserRecommended: true,
                  recommendedCount: 10,
                  thumbnailImageURL: "",
                  imageURL: [])
        ]
    }

    static func detailReviews() -> [DetailReview] {
        return [
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", tags: [.init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구 저쩌구"), recommendedCount: 0)]),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description", tags: [.init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구 저쩌구"), recommendedCount: 0)]),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description",
                  tags: [.init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런태그 저런"), recommendedCount: 0)]),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description",
                  tags: [.init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0)]),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description",
                  tags: [.init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0)])
        ]
    }

    static func tagReviews() -> [TagReview] {
        return [
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "친절해요"),
                  recommendedCount: 3),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "청결해요"),
                  recommendedCount: 4),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "배고파요"),
                  recommendedCount: 5),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "살려줘요"),
                  recommendedCount: 6)
        ]
    }

    private init() {}
}
