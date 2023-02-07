//
//  ReviewDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/07.
//

import Foundation

struct ReviewUploadDTO: Encodable {
    let storeId: Int
    let reviewText: String
    let imgPath: [String]
    let reviewTagIds: [Int]
}

struct ReviewUploadResponse: Decodable {
    let reviewId: Int
}
