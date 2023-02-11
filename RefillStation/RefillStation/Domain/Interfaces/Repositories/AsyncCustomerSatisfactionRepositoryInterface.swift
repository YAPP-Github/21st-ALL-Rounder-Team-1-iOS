//
//  AsyncCustomerSatisfactionRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

protocol AsyncCustomerSatisfactionRepositoryInterface {
    func upload(requestValue: CustomerSatisfactionRequestValue) async throws
}
