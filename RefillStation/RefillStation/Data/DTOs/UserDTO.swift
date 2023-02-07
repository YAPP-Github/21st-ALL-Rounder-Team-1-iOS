//
//  UserDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/07.
//

import Foundation

struct UserDTO: Decodable {
    let createdAt, modifiedAt: String?
    let id: Int?
    let name, nickname, email, phoneNumber: String?
    let type, oauthType, oauthIdentity: String?
    let rating: Int?
    let imgPath: String?
}

extension UserDTO {
    func toDomain() -> User {
        return User(
            id: id ?? 0,
            name: nickname ?? "",
            imageURL: imgPath ?? "",
            level: UserLevelInfo(level: UserLevelInfo.Level(rawValue: rating ?? 0) ?? .beginner)
        )
    }
}
