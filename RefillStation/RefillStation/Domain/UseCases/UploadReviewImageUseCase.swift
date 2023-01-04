//
//  UploadReviewImageUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import UIKit

struct UploadReviewImageRequestValue {
    let images: [UIImage]
}

protocol UploadReviewImageUseCaseInterface {
    func execute(requestValue: UploadReviewImageRequestValue,
                 completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable?
}

final class UploadReviewImageUseCase: UploadReviewImageUseCaseInterface {
    private let registerReviewRepository: RegisterReviewRepositoryInterface

    init(registerReviewRepository: RegisterReviewRepositoryInterface = MockRegisterReviewRepository()) {
        self.registerReviewRepository = registerReviewRepository
    }

    func execute(requestValue: UploadReviewImageRequestValue,
                 completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
