//
//  UploadReviewImageUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import UIKit

struct UploadImageRequestValue {
    let images: [UIImage]
}

protocol UploadImageUseCaseInterface {
    func execute(requestValue: UploadImageRequestValue,
                 completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable?
}

final class UploadImageUseCase: UploadImageUseCaseInterface {
    private let uploadImageRepository: UploadImageRepositoryInterface

    init(uploadImageRepository: UploadImageRepositoryInterface = MockUploadImageRepository()) {
        self.uploadImageRepository = uploadImageRepository
    }

    func execute(requestValue: UploadImageRequestValue,
                 completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
