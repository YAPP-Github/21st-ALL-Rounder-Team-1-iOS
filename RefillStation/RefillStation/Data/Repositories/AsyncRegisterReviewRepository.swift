//
//  AsyncRegisterReviewRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import UIKit

final class AsyncRegisterReviewRepository: AsyncRegisterReviewRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let awsService: AWSS3Service

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        awsService: AWSS3Service = AWSS3Service.shared
    ) {
        self.networkService = networkService
        self.awsService = awsService
    }

    func registerReview(query: RegiserReviewRequestValue) async throws {
        try await withThrowingTaskGroup(of: String.self, body: { taskGroup in
            var imagePaths = [String]()
            for image in query.images {
                taskGroup.addTask {
                    return try await self.awsService.upload(type: .review, image: image)
                }
            }

            for try await imagePath in taskGroup {
                imagePaths.append(imagePath)
            }

            try await taskGroup.waitForAll()

            var urlComponents = URLComponents(string: self.networkService.baseURL)
            urlComponents?.path = "/api/store/review"
            let reviewDTO = ReviewUploadDTO(
                storeId: query.storeId,
                reviewText: query.description,
                imgPath: imagePaths,
                reviewTagIds: query.tagIds
            )
            guard let requestBody = try? JSONEncoder().encode(reviewDTO) else {
                throw RepositoryError.requestParseFailed
            }
            guard let request = urlComponents?.toURLRequest(
                method: .post,
                httpBody: requestBody
            ) else {
                throw RepositoryError.urlParseFailed
            }

            let _: ReviewUploadResponse = try await networkService.dataTask(request: request)
        })
    }
}
