//
//  RefillStationTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2022/11/23.
//

import XCTest
@testable import RefillStation

class FetchStoresTest: XCTestCase {

    var sucessTestUnit: AsyncStoreRepository!
    var failureTestUnit: AsyncStoreRepository!
    let dataToReturn =
"""
{
    "message": "유저 위치 가게 정보 불러오기 성공",
    "status": 200,
    "data": [
        {
            "id": 340,
            "userId": null,
            "name": "시리얼에코리필스테이션 롯데마트 제타플렉스점",
            "status": "VIEW",
            "longitude": "127.0979980000",
            "latitude": "37.5112601000",
            "businessHour": [
                {
                    "day": "월",
                    "time": "10:00~23:00"
                },
                {
                    "day": "화",
                    "time": "10:00~23:00"
                },
                {
                    "day": "수",
                    "time": "10:00~23:00"
                },
                {
                    "day": "목",
                    "time": "10:00~23:00"
                },
                {
                    "day": "금",
                    "ime": "10:00~23:00"
                },
                {
                    "day": "토",
                    "time": "10:00~23:00"
                },
                {
                    "day": "일",
                    "time": "10:00~23:00"
                }
            ],
            "notice": "2, 4번째 일요일 휴무",
            "address": "서울특별시 송파구 올림픽로 240 롯데제타플렉스",
            "instaAccount": null,
            "callNumber": "02-411-8025",
            "registrationNumber": "219-85-06129",
            "isReady": null,
            "distance": "1148.4069744630049",
            "imgStores": [
                {
                    "createdAt": "2023-02-18T14:39:54",
                    "modifiedAt": null,
                    "id": 126,
                    "storeId": 340,
                    "path": "https://pump-img-bucket.s3.ap-northeast-2.amazonaws.com/store/Cereal.png"
                }
            ],
            "storeRefillGuides": []
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
            networkService: MockNetworkService(baseURL: "🥰", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_fetchStores_호출시_Store_배열을_반환하는지() async throws {
        // given
        let requestValue = FetchStoresUseCaseRequestValue(latitude: 30, longitude: 40)
        // when
        let stores = try await sucessTestUnit.fetchStores(requestValue: requestValue)
        // then
        do {
            let networkResult = try JSONDecoder().decode(NetworkResult<[StoreDTO]>.self, from: dataToReturn)
            let storesResult = networkResult.data.map { $0.toDomain() }
            XCTAssertEqual(stores, storesResult)
        } catch {
            XCTFail("failed")
        }
    }

    func test_잘못된_baseURL로_fetchStores_호출시_jsonParseFailed를_throw_하는지() {
        // given
        let requestValue = FetchStoresUseCaseRequestValue(latitude: 30, longitude: 40)
        Task {
            do {
                // when
                _ = try await failureTestUnit.fetchStores(requestValue: requestValue)
            } catch {
                // then
                XCTAssertThrowsError(RepositoryError.urlParseFailed)
            }
        }
    }
}
