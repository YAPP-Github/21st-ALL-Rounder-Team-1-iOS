//
//  UserInfoRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/07.
//

import Foundation

final class UserInfoRepository: UserInfoRepositoryInterface {

    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
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
        return nil
    }

    func validNickname(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return nil
    }

    func fetchUserReviews(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        return nil
    }
}
