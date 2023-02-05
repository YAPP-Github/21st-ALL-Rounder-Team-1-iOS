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

struct FetchStoreRecommendResult {
    var didUserRecommended: Bool
    var recommendedCount: Int
}

struct StoreRecommendRequestDTO: Encodable {
    let storeId: Int
}

extension StoreRecommendDTO {
    func toFetchResult() -> FetchStoreRecommendResult {
        return FetchStoreRecommendResult(
            didUserRecommended: isRecommendation ?? false,
            recommendedCount: count ?? 0
        )
    }

    func toResponseValue() -> RecommendStoreResponseValue {
        return RecommendStoreResponseValue(
            recommendCount: count ?? 0,
            didRecommended: isRecommendation ?? false
        )
    }
}
