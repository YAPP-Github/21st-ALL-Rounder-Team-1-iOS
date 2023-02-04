//
//  StoreRecommendDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/04.
//

import Foundation

struct StoreRecommendDTO {
    let recommendation: Bool?
    let count: Int?
}

struct FetchStoreRecommendResult {
    var didUserRecommended: Bool
    var recommendedCount: Int
}

extension StoreRecommendDTO {
    func toFetchResult() -> FetchStoreRecommendResult {
        return FetchStoreRecommendResult(
            didUserRecommended: recommendation ?? false,
            recommendedCount: count ?? 0
        )
    }
}
