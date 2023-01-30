//
//  MockRepositories.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit

final class MockUploadImageRepository: UploadImageRepositoryInterface {
    func uploadImage(images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable? {
        let dummyStrings = Array.init(repeating: "", count: images.count)
        return MockTask { completion(.success(dummyStrings)) }
    }
}

final class MockAccountRepository: AccountRepositoryInterface {
    func OAuthLogin(loginType: OAuthType, completion: @escaping (Result<String?, Error>) -> Void) -> Cancellable? {
        let jwtToken: String? = nil
        return MockTask { completion(.success(jwtToken)) }
    }

    func withdraw(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return MockTask { completion(.success(())) }
    }

    func createNickname(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        let randomNickname = "randomNickname"
        return MockTask { completion(.success(randomNickname)) }
    }

    func signUp(requestValue: SignUpRequestValue, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        let jwtToken = "jwtToken"
        return MockTask { completion(.success(jwtToken)) }
    }
}

final class MockCustomerSatisfactionRepository: CustomerSatisfactionRepositoryInterface {
    func upload(type: CustomerSatisfactionType, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return MockTask { completion(.success(())) }
    }
}

final class MockUserInfoRepository: UserInfoRepositoryInterface {
    func fetchProfile(completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        let dummyUser = User(id: 1, name: "Neph", imageURL: "",
                             level: .init(level: .beginner, remainCountForNextLevel: 1))
        return MockTask { completion(.success(dummyUser)) }
    }

    func editProfile(requestValue: EditProfileRequestValue, completion: @escaping (Result<User, Error>) -> Void) -> Cancellable? {
        let dummyUser = User(id: 1, name: "변경된Neph", imageURL: "",
                             level: .init(level: .beginner, remainCountForNextLevel: 1))
        return MockTask { completion(.success(dummyUser)) }
    }

    func validNickname(requestValue: ValidNicknameRequestValue, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return MockTask { completion(.success(true)) }
    }

    func fetchUserReviews(completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        let dummyReviews = MockEntityData.reviews()
        return MockTask { completion(.success(dummyReviews)) }
    }
}

final class MockStoreRepository: StoreRepositoryInterface {
    func fetchStores(requestValue: FetchStoresUseCaseRequestValue, completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable? {
        let dummyStores = MockEntityData.stores()
        return MockTask { completion(.success(dummyStores)) }
    }

    func fetchProducts(requestValue: FetchProductsRequestValue, completion: @escaping (Result<[Product], Error>) -> Void) -> Cancellable? {
        let dummyProducts = MockEntityData.products()
        return MockTask { completion(.success(dummyProducts)) }
    }

    func fetchStoreReviews(requestValue: FetchStoreReviewsRequestValue, completion: @escaping (Result<[Review], Error>) -> Void) -> Cancellable? {
        let dummyReviews = MockEntityData.reviews()
        return MockTask { completion(.success(dummyReviews)) }
    }

    func recommendStore(requestValue: RecommendStoreRequestValue, completion: @escaping (Result<RecommendStoreResponseValue, Error>) -> Void) -> Cancellable? {
        let dummyResponse = RecommendStoreResponseValue(recommendCount: 10, didRecommended: true)
        return MockTask { completion(.success(dummyResponse)) }
    }
}

final class MockRegisterReviewRepository: RegisterReviewRepositoryInterface {
    func registerReview(query: RegiserReviewRequestValue, completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable? {
        return MockTask { completion(.success(())) }
    }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.task?()
        }
    }

    func cancel() {
        task = nil
    }
}
