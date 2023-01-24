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
            .init(name: "name1", brand: "brand1", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸1샴푸1샴푸1샴푸1샴푸1샴푸1샴푸1샴푸1")),
            .init(name: "name2", brand: "brand2", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸2샴푸2샴푸2")),
            .init(name: "name3", brand: "brand3", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸3")),
            .init(name: "name4", brand: "brand4", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸4")),
            .init(name: "name5", brand: "brand1", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸1")),
            .init(name: "name6", brand: "brand2", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸2")),
            .init(name: "name7", brand: "brand3", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸3")),
            .init(name: "name8", brand: "brand4", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸4")),
            .init(name: "name9", brand: "brand1", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸1")),
            .init(name: "name10", brand: "brand2", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸2")),
            .init(name: "name11", brand: "brand3", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸3")),
            .init(name: "name12", brand: "brand4", measurement: "mea", price: 1, imageURL: "", category: .init(title: "샴푸4"))
        ]
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
            .init(user: .init(id: 0, name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: [""],
                  description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", tags: [.init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구 저쩌구"), recommendedCount: 0)]),
            .init(user: .init(id: 0, name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: [""],
                  description: "description", tags: [.init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구 저쩌구"), recommendedCount: 0)]),
            .init(user: .init(id: 0, name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: [""],
                  description: "description",
                  tags: [.init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런"), recommendedCount: 0),
                         .init(tag: .init(image: UIImage(), title: "이런태그 저런"), recommendedCount: 0)]),
            .init(user: .init(id: 0, name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: [""],
                  description: "description",
                  tags: [.init(tag: .init(image: UIImage(), title: "이런태그"), recommendedCount: 0)]),
            .init(user: .init(id: 0, name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: [""],
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
                  recommendedCount: 6),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "친절해요"),
                  recommendedCount: 3),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "청결해요"),
                  recommendedCount: 4),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "배고파요"),
                  recommendedCount: 5),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "살려줘요"),
                  recommendedCount: 6),
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

    static func tags() -> [Tag] {
        return [
            .init(image: UIImage(), title: "포인트 적립이 가능해요"),
            .init(image: UIImage(), title: "품목이 다양해요"),
            .init(image: UIImage(), title: "점원이 친절해요"),
            .init(image: UIImage(), title: "위치 접근성이 좋아요"),
            .init(image: UIImage(), title: "가격이 합리적이에요"),
            .init(image: UIImage(), title: "매장이 커요"),
            .init(image: UIImage(), title: "매장이 청결해요"),
            .init(image: UIImage(), title: "선택할 키워드가 없어요")
        ]
    }

    static func operations() -> [OperationInfo] {
        return [
            .init(image: UIImage(systemName: "clock")!, content: "월 11:00 - 18:00 \n화 12:00 - 18:00\n수 13:00 - 18:00"),
            .init(image: UIImage(systemName: "person")!, content: "뭔가 있음"),
            .init(image: UIImage(systemName: "star")!, content: "뭔가 있음")
        ]
    }

    private init() {}
}
