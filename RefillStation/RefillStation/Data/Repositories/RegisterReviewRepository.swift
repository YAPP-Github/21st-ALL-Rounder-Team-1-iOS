//
//  RegisterReviewRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/07.
//

import Foundation

final class RegisterReviewRepository: RegisterReviewRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let awsService: AWSS3Service

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        awsService: AWSS3Service = AWSS3Service.shared
    ) {
        self.networkService = networkService
        self.awsService = awsService
    }

    func registerReview(query: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return ImageUploadTask { [weak self] in
            guard let self = self else { return }
            let dispatchGroup = DispatchGroup()
            let images = query.images
            var imageURLs = [String]()
            dispatchGroup.enter()
            images.indexed().forEach { index, item in
                self.awsService.upload(type: .review, image: item) { result in
                    switch result {
                    case .success(let imageURL):
                        imageURLs.append(imageURL)
                        if index == images.count - 1 {
                            dispatchGroup.leave()
                        }
                    case .failure:
                        completion(.failure(RepositoryError.imageUploadFailed))
                    }
                }
            }
            if images.isEmpty { dispatchGroup.leave() }

            dispatchGroup.notify(queue: .global()) {
                var urlComponents = URLComponents(string: self.networkService.baseURL)
                urlComponents?.path = "/api/store/review"
                let reviewDTO = ReviewUploadDTO(
                    storeId: query.storeId,
                    reviewText: query.description,
                    imgPath: imageURLs,
                    reviewTagIds: query.tagIds
                )
                guard let requestBody = try? JSONEncoder().encode(reviewDTO) else {
                    completion(.failure(RepositoryError.requestParseFailed))
                    return
                }
                guard let request = urlComponents?.toURLRequest(
                    method: .post,
                    httpBody: requestBody
                ) else {
                    completion(.failure(RepositoryError.urlParseFailed))
                    return
                }

                self.networkService.dataTask(request: request) { (result: Result<ReviewUploadResponse, Error>) in
                    switch result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }?.resume()
            }
        }
    }
}
