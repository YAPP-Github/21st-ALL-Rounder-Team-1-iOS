//
//  RegisterReviewUseCase.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import UIKit

struct RegisterReviewRequestValue {
    let storeId: Int
    let tagIds: [Int]
    let images: [UIImage?] // image 업로드는 UploadImageUseCase를 사용하여 진행 후 String 배열로 변환
    let description: String
}

protocol RegisterReviewUseCaseInterface {
    func execute(requestValue: RegisterReviewRequestValue) async throws
}

final class RegisterReviewUseCase: RegisterReviewUseCaseInterface {

    private let registerReviewRepository: AsyncRegisterReviewRepositoryInterface

    init(registerReviewRepository: AsyncRegisterReviewRepositoryInterface = AsyncRegisterReviewRepository()) {
        self.registerReviewRepository = registerReviewRepository
    }

    func execute(requestValue: RegisterReviewRequestValue) async throws {
        return try await registerReviewRepository.registerReview(query: requestValue)
    }
}
