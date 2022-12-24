//
//  DefaultProductListRepository.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation
import Alamofire

final class ProductListRepository: ProductListRepositoryInterface {
    func fetchProductList(
        query: FetchProductListRequestValue,
        completion: @escaping (Result<[Product], Error>) -> Void
    ) -> Cancellable {
        return AF.session.dataTask(with: URL(string: "")!)
    }
}
