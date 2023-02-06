//
//  StoreRecommendDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/04.
//

import Foundation

struct StoreRecommendDTO: Decodable {
    let isRecommendation: Bool?
    let count: Int?
}

struct StoreRecommendRequestDTO: Encodable {
    let storeId: Int
}

extension StoreRecommendDTO {
    func toResponseValue() -> RecommendStoreResponseValue {
        return RecommendStoreResponseValue(
            recommendCount: count ?? 0,
            didRecommended: isRecommendation ?? false
        )
    }
}
