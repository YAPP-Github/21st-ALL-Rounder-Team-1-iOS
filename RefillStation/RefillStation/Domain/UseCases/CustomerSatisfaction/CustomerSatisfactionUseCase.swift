//
//  CustomerSatisfactionUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

enum CustomerSatisfactionType {
    case requestRegion
    case reportUser
}

protocol CustomerSatisfactionUseCaseInterface {
    func execute(type: CustomerSatisfactionType, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}

final class CustomerSatisfactionUseCase: CustomerSatisfactionUseCaseInterface {
    private let customerSatisfactionRepository: CustomerSatisfactionRepositoryInterface

    init(customerSatisfactionRepository: CustomerSatisfactionRepositoryInterface) {
        self.customerSatisfactionRepository = customerSatisfactionRepository
    }

    func execute(type: CustomerSatisfactionType, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
