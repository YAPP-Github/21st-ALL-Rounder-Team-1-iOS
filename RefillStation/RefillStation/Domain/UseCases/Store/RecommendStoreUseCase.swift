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

protocol RecommendStoreUseCaseInterface {
    func execute(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<Int, Error>) -> Void) -> Cancellable?
}

final class RecommendStoreUseCase: RecommendStoreUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = MockStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<Int, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
