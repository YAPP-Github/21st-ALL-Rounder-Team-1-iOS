//
//  ProductListRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol ProductsRepositoryInterface {
    func fetchProducts(
        query: FetchProductsRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable?
}
