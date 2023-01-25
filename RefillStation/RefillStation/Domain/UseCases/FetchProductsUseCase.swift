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
    func execute(
        requestValue: FetchProductsRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable?
}

final class FetchProductsUseCase: FetchProductsUseCaseInterface {
    private let productsRepository: ProductsRepositoryInterface

    init(productsRepository: ProductsRepositoryInterface = MockProductsRepository()) {
        self.productsRepository = productsRepository
    }

    @discardableResult
    func execute(
        requestValue: FetchProductsRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable? {

        return productsRepository.fetchProducts(query: requestValue) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
