//
//  RecommendStoreUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct RecommendStoreRequestValue {
    enum `Type` {
        case recommend
        case cancel
    }
    let storeId: Int
    let type: `Type`
}

struct RecommendStoreResponseValue {
    let recommendCount: Int
    let didRecommended: Bool
}

protocol RecommendStoreUseCaseInterface {
    func execute(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable?
}

final class RecommendStoreUseCase: RecommendStoreUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = MockStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable? {
        return storeRepository.recommendStore(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
