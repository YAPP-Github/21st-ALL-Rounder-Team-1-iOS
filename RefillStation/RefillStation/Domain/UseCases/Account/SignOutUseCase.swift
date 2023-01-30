//
//  SignOutUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol SignOutUseCaseInterface {
    func execute(completion: @escaping (Result<Void, Error>) -> Void)
}

final class SignOutUseCase: SignOutUseCaseInterface {
    func execute(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
