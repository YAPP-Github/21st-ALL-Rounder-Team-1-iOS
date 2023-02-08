//
//  UserRequestDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/08.
//

import Foundation

struct EditUserRequestDTO: Codable {
    let nickname: String
    let rating: Int
    let imagePath: String
}
