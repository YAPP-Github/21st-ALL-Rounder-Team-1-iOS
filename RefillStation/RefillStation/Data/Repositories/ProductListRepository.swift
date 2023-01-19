//
//  DefaultProductListRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

final class ProductListRepository: ProductListRepositoryInterface {
    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }

    func fetchProductList(
        query: FetchProductListRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable {
        return URLSessionDataTask()
    }
}
