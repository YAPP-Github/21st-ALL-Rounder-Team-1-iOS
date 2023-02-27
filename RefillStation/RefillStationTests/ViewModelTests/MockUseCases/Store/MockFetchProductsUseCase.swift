//
//  MockFetchProductsUseCase.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class MockFetchProductUseCase: FetchProductsUseCaseInterface {

    private let products: [Product]
    private let error: Error?

    init(products: [Product], error: Error? = nil) {
        self.products = products
        self.error = error
    }
    func execute(requestValue: RefillStation.FetchProductsRequestValue) async throws -> [RefillStation.Product] {
        if let error = error {
            throw error
        }
        return products
    }
}
