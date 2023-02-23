//
//  AsyncUserInfoRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

final class AsyncUserInfoRepository: AsyncUserInfoRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let awsService: AWSS3ServiceInterface

    init(
        networkService: NetworkServiceInterface = NetworkService.shared,
        awsService: AWSS3ServiceInterface = AWSS3Service.shared
    ) {
        self.networkService = networkService
        self.awsService = awsService
    }

    func fetchProfile() async throws -> User {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }

        let userDTO: UserDTO = try await networkService.dataTask(request: request)
        return userDTO.toDomain()
    }

    func editProfile(requestValue: EditProfileRequestValue) async throws -> User {
        var urlComponents = URLComponents(string: self.networkService.baseURL)
        urlComponents?.path = "/api/user"
        let imagePath = requestValue.didImageChanged ? try await awsService.upload(
            type: .user, image: requestValue.newImage) : requestValue.oldImagePath
        guard let requestBody = try? JSONEncoder()
            .encode(EditUserRequestDTO(
                nickname: requestValue.nickname,
                rating: requestValue.rating,
                imgPath: imagePath)) else {
            throw RepositoryError.requestParseFailed
        }
        guard let request = urlComponents?.toURLRequest(method: .patch, httpBody: requestBody) else {
            throw RepositoryError.urlParseFailed
        }

        let userDTO: UserDTO = try await networkService.dataTask(request: request)
        return userDTO.toDomain()
    }

    func validNickname(requestValue: ValidNicknameRequestValue) async throws -> Bool {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/\(requestValue.nickname)"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }

        let isDuplicated: Bool = try await networkService.dataTask(request: request)
        return isDuplicated
    }

    func fetchUserReviews() async throws -> [Review] {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/reviews"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }

        let reviewDTOs: [ReviewDTO] = try await networkService.dataTask(request: request)
        return reviewDTOs.map { $0.toDomain() }
    }
}
