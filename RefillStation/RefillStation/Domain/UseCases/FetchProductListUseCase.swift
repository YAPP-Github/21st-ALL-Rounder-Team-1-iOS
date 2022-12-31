//
//  FetchProductListUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

struct FetchProductListRequestValue {
    let storeId: Int
}

protocol FetchProductListUseCaseInterface {
    func execute(
        requestValue: FetchProductListRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable?
}

final class FetchProductListUseCase: FetchProductListUseCaseInterface {
    private let productListRepository: ProductListRepositoryInterface

    init(productListRepository: ProductListRepositoryInterface = MockProductListRepository()) {
        self.productListRepository = productListRepository
    }

    @discardableResult
    func execute(
        requestValue: FetchProductListRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable? {

        return productListRepository.fetchProductList(query: requestValue) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class MockProductListRepository: ProductListRepositoryInterface {
    func fetchProductList(query: FetchProductListRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable {
        return URLSessionDataTask()
    }
}
