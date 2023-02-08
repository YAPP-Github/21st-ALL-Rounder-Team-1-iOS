//
//  CustomerSatisfactionRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/08.
//

import Foundation

final class CustomerSatisfactionRepository: CustomerSatisfactionRepositoryInterface {

    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
    }

    func upload(type: CustomerSatisfactionType, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
