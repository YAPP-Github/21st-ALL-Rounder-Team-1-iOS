//
//  FetchProductListUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct FetchProductsRequestValue {
    let storeId: Int
}

protocol FetchProductsUseCaseInterface {
    func execute(requestValue: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable?
}

final class FetchProductsUseCase: FetchProductsUseCaseInterface {
    private let storeRepository: StoreRepositoryInterface

    init(storeRepository: StoreRepositoryInterface = MockStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable? {
        return storeRepository.fetchProducts(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
