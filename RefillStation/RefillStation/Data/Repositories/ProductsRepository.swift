//
//  DefaultProductListRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

final class ProductsRepository: ProductsRepositoryInterface {
    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }

    func fetchProducts(
        query: FetchProductsRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable? {
        return nil
    }
}
