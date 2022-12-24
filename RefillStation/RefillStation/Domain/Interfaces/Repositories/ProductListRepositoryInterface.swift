//
//  ProductListRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol ProductListRepositoryInterface {
    func fetchProductList(
        query: FetchProductListRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    )
}
