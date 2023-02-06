//
//  FetchStoreRecommendDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

struct FetchStoreRecommendDTO: Decodable {
    let recommendation: Bool?
    let count: Int?
}

struct FetchStoreRecommendRequestDTO: Encodable {
    let storeId: Int
}

extension FetchStoreRecommendDTO {
    func toResponseValue() -> FetchStoreRecommendResponseValue {
        return FetchStoreRecommendResponseValue(
            recommendCount: count ?? 0,
            didRecommended: recommendation ?? false
        )
    }
}
