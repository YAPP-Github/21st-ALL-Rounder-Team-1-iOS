//
//  RegisterReviewUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import UIKit

struct RegiserReviewRequestValue {
    let storeId: Int
    let tagIds: [Int]
    let images: [UIImage?] // image 업로드는 UploadImageUseCase를 사용하여 진행 후 String 배열로 변환
    let description: String
}

protocol RegisterReviewUseCaseInterface {
    func execute(requestValue: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?
}

final class RegisterReviewUseCase: RegisterReviewUseCaseInterface {

    private let registerReviewRepository: RegisterReviewRepositoryInterface

    init(registerReviewRepository: RegisterReviewRepositoryInterface = RegisterReviewRepository()) {
        self.registerReviewRepository = registerReviewRepository
    }

    func execute(requestValue: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return registerReviewRepository.registerReview(query: requestValue) { result in
            completion(result)
        }
    }
}
