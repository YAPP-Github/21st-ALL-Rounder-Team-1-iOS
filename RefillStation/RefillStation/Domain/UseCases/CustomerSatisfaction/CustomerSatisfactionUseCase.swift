//
//  CustomerSatisfactionUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

enum CustomerSatisfactionType: Int {
    case requestRegion = 1
    case reportUser = 2
}

struct CustomerSatisfactionRequestValue {
    let userId: Int
    let content: String
    let type: CustomerSatisfactionType
}

protocol CustomerSatisfactionUseCaseInterface {
    func execute(requestValue: CustomerSatisfactionRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}

final class CustomerSatisfactionUseCase: CustomerSatisfactionUseCaseInterface {
    private let customerSatisfactionRepository: CustomerSatisfactionRepositoryInterface

    init(customerSatisfactionRepository: CustomerSatisfactionRepositoryInterface = MockCustomerSatisfactionRepository()) {
        self.customerSatisfactionRepository = customerSatisfactionRepository
    }

    func execute(requestValue: CustomerSatisfactionRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return customerSatisfactionRepository.upload(requestValue: requestValue) { result in
            completion(result)
        }
    }
}
