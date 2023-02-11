//
//  ReviewDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/04.
//

import Foundation

struct ReviewDTO: Decodable {
    let id: Int?
    let storeId: Int?
    let userId: Int?
    let reviewText: String?
    let createdAt: String?
    let modifiedAt: String?
    let user: UserDTO?
    let imgReviews: [ImageReviewDTO]?
    let reviewTagLogs: [ReviewTagLogsDTO]?
    struct UserDTO: Decodable {
        let createdAt: String?
        let modifiedAt: String?
        let id: Int?
        let name: String?
        let nickname: String?
        let email: String?
        let phoneNumber: String?
        let type: String?
        let oauthType: String?
        let oauthIdentity: String?
        let rating: Int?
        let imgPath: String?
        let removedAt: String?
    }
    struct ImageReviewDTO: Decodable {
        let createdAt: String?
        let modifiedAt: String?
        let id: Int?
        let reviewId: Int?
        let path: String?
    }
    struct ReviewTagLogsDTO: Decodable {
        let createdAt: String?
        let modifiedAt: String?
        let id: Int?
        let reviewId: Int?
        let userId: Int?
        let storeId: Int?
        let reviewTagId: Int?
    }
}

extension ReviewDTO {
    func toDomain() -> Review {
        return Review(
            userId: user?.id ?? 0,
            userNickname: user?.nickname ?? "",
            profileImagePath: user?.imgPath ?? "",
            writtenDate: (createdAt ?? "").toDate() ?? Date(),
            imageURL: imgReviews?.compactMap {
                $0.path
            } ?? [],
            description: reviewText ?? "",
            tags: reviewTagLogs?.map {
                return Tag(rawValue: $0.reviewTagId ?? 0) ?? .noKeywordToChoose
            } ?? []
        )
    }
}

fileprivate extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ""
        return dateFormatter.date(from: self)
    }
}
