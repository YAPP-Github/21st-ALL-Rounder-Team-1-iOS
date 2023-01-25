//
//  CreateNicknameUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol CreateNicknameUseCaseInterface {
    func execute(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}

final class CreateNicknameUseCase: CreateNicknameUseCaseInterface {
    private let accountRepository: AccountRepositoryInterface

    init(accountRepository: AccountRepositoryInterface) {
        self.accountRepository = accountRepository
    }

    func execute(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        return nil
    }
}
