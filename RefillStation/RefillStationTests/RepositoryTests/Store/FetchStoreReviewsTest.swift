//
//  FetchStoreReviewsTest.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/22.
//

import XCTest
@testable import RefillStation

class FetchStoreReviewsTest: XCTestCase {

    var sucessTestUnit: AsyncStoreRepository!
    var failureTestUnit: AsyncStoreRepository!
    let dataToReturn =
"""
{
    "message": "가게 정보 리뷰 불러오기 성공.",
    "status": 200,
    "data": [
        {
            "id": 282,
            "storeId": 335,
            "userId": 148,
            "reviewText": "길음역이랑 가까워요! 가게는 아담하지만 판매하고 있는 품목이 다양해서 구경하는 재미가 있었습니다~ 이번에는 재생지로 만든 노트 두 권을 구매했는데, 다음에는 빈 병 챙겨서 식료품을 리필하러 가려구요! 가게에서 플라스틱 자원수거 행사도 하시던데, 다음 번 방문 전에 열심히 모아서 갈 생각이에요 ㅎㅎ ",
            "createdAt": "2023-02-18T01:20:42",
            "modifiedAt": "2023-02-18T01:20:42",
            "user": {
                "createdAt": "2023-02-17T07:16:52",
                "modifiedAt": "2023-02-18T01:20:42",
                "id": 148,
                "name": null,
                "nickname": "어둠의떡사모",
                "email": null,
                "phoneNumber": null,
                "type": "USER",
                "oauthType": "KAKAO",
                "oauthIdentity": "2662093142",
                "rating": 2,
                "imgPath": "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/user/D1E39557-8E37-4171-B9FB-868E830CF8CD.jpeg",
                "removedAt": null
            },
            "imgReviews": [
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 148,
                    "reviewId": 282,
                    "path": "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/review/341C24CC-FFE0-4D5B-AA41-DF531471E771.jpeg",
                    "removedAt": null
                },
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 149,
                    "reviewId": 282,
                    "path": "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/review/40433E98-175E-4A09-8EAD-8F5B5825326A.jpeg",
                    "removedAt": null
                },
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 150,
                    "reviewId": 282,
                    "path": "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/review/A3EC159D-0F25-4B57-932A-FE762926B028.jpeg",
                    "removedAt": null
                }
            ],
            "reviewTagLogs": [
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 455,
                    "reviewId": 282,
                    "userId": 148,
                    "storeId": 335,
                    "reviewTagId": 2,
                    "removedAt": null
                },
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 456,
                    "reviewId": 282,
                    "userId": 148,
                    "storeId": 335,
                    "reviewTagId": 3,
                    "removedAt": null
                },
                {
                    "createdAt": "2023-02-18T01:20:42",
                    "modifiedAt": "2023-02-18T01:20:42",
                    "id": 457,
                    "reviewId": 282,
                    "userId": 148,
                    "storeId": 335,
                    "reviewTagId": 4,
                    "removedAt": null
                }
            ]
        }
    ]
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncStoreRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncStoreRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_fetchStoreReviews_호출시_Review_배열을_반환하는지() async throws {
        // given
        let requestValue = FetchStoreReviewsRequestValue(storeId: 330)
        // when
        let reviews = try await sucessTestUnit.fetchStoreReviews(requestValue: requestValue)
        // then
        do {
            let networkResult = try JSONDecoder().decode(NetworkResult<[ReviewDTO]>.self, from: dataToReturn)
            let reviewsResult = networkResult.data.map { $0.toDomain() }
            XCTAssertEqual(reviews, reviewsResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_fetchStoreReviews_호출시_urlParseFailed를_throw_하는지() async {
        // given
        let requestValue = FetchStoreReviewsRequestValue(storeId: 330)

        do {
            // when
            _ = try await failureTestUnit.fetchStoreReviews(requestValue: requestValue)
            XCTFail()
        } catch {
            // then
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }
}
