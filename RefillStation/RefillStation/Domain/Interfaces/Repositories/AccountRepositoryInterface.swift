//
//  AccountRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol AccountRepositoryInterface {
    func signUp(requestValue: SignUpRequestValue, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}
