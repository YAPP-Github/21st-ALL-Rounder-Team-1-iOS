//
//  MockRepositories.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit

final class MockHomeRepository: HomeRepositoryInterface {
    func fetchStoreList(query: FetchStoresUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}

final class MockProductsRepository: ProductsRepositoryInterface {
    func fetchProducts(query: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable? {
        return nil
    }
}

final class MockStoreReviewRepository: StoreReviewRepositoryInterface {

}

final class MockRequestRegionRepository: RequestRegionRepositoryInterface {

}

final class MockRegisterReviewRepository: RegisterReviewRepositoryInterface {
    func fetchTags(completion: @escaping (Result<[Tag], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }

    func registerReview(query: RegiserReviewRequestValue, completion: @escaping (Result<Never, Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }

    func uploadReviewImage(query: UploadImageRequestValue, completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        return URLSession.shared.dataTask(with: URLRequest(url: URL(string: "")!))
    }
}

final class MockUploadImageRepository: UploadImageRepositoryInterface {
    func uploadImage(images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {

        let dummyStrings = Array.init(repeating: "",
                                      count: images.count)

        return MockTask {
            completion(.success(dummyStrings))
        }
    }
}

final class MockAccountRepository: AccountRepositoryInterface {
    func OAuthLogin(loginType: OAuthType, completion: @escaping (Result<String?, Error>) -> Void) -> Cancellable? {
        let jwtToken = "jwtToken"
        return MockTask {
            completion(.success(jwtToken))
        }
    }

    func withdraw(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return MockTask {
            completion(.success(()))
        }
    }

    func createNickname(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        let randomNickname = "randomNickname"
        return MockTask {
            completion(.success(randomNickname))
        }
    }

    func signUp(requestValue: SignUpRequestValue, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        let jwtToken = "jwtToken"
        return MockTask {
            completion(.success(jwtToken))
        }
    }
}

final class MockStoreRepository: StoreRepositoryInterface {

}

/// init을 통해 내부 변수 task를 전달받습니다.
/// resume()을 실행하면 2초 뒤 task를 실행합니다.
/// cancel()를 실행하면 task에 nil을 할당합니다.
final class MockTask: Cancellable {
    var task: (() -> Void)?

    init(task: @escaping (() -> Void)) {
        self.task = task
    }

    func resume() {
        task?()
    }

    func cancel() {
        task = nil
    }
}
