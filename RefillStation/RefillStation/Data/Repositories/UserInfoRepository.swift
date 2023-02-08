//
//  UserInfoRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/07.
//

import Foundation

final class UserInfoRepository: UserInfoRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let awsService: AWSS3Service

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        awsService: AWSS3Service = AWSS3Service.shared
    ) {
        self.networkService = networkService
        self.awsService = awsService
    }

    func fetchProfile(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }

        return networkService.dataTask(request: request) { (result: Result<UserDTO, Error>) in
            switch result {
            case .success(let userDTO):
                completion(.success(userDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func editProfile(requestValue: EditProfileRequestValue, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        return ImageUploadTask { [weak self] in
            guard let self = self else { return }
            let dispatchGroup = DispatchGroup()
            var imagePath = requestValue.oldImagePath
            var urlComponents = URLComponents(string: self.networkService.baseURL)
            urlComponents?.path = "/api/user"

            dispatchGroup.enter()

            if requestValue.newImage == nil {
                dispatchGroup.leave()
            } else {
                self.awsService.upload(type: .review, image: requestValue.newImage) { result in
                    switch result {
                    case .success(let imageURL):
                        imagePath = imageURL
                    case .failure:
                        completion(.failure(RepositoryError.imageUploadFailed))
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .global()) {
                guard let requestBody = try? JSONEncoder()
                    .encode(EditUserRequestDTO(
                        nickname: requestValue.nickname,
                        rating: requestValue.rating,
                        imagePath: imagePath)) else {
                    completion(.failure(RepositoryError.requestParseFailed))
                    return
                }
                guard let request = urlComponents?.toURLRequest(method: .patch, httpBody: requestBody) else {
                    completion(.failure(RepositoryError.urlParseFailed))
                    return
                }
                self.networkService.dataTask(request: request) { (result: Result<UserDTO, Error>) in
                    switch result {
                    case .success(let userDTO):
                        completion(.success(userDTO.toDomain()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }?.resume()
            }
        }
    }

    func validNickname(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/\(requestValue.nickname)"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }

        return networkService.dataTask(request: request) { (result: Result<Bool, Error>) in
            switch result {
            case .success(let isDulplicated):
                completion(.success(isDulplicated))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchUserReviews(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/reviews"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            completion(.failure(RepositoryError.urlParseFailed))
            return nil
        }

        return networkService.dataTask(request: request) { (result: Result<[ReviewDTO], Error>) in
            switch result {
            case .success(let reviews):
                completion(.success(reviews.map { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
