//
//  CustomerSatisfactionRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/30.
//

import Foundation

protocol CustomerSatisfactionRepositoryInterface {
    func upload(type: CustomerSatisfactionType, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}
