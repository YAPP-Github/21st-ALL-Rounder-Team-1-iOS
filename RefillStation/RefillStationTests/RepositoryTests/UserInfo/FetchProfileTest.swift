//
//  FetchProfileTest.swift
//  RefillStationTests
//
//  Created by kong on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class FetchProfileTest: XCTestCase {
    var sucessTestUnit: AsyncUserInfoRepository!
    var failureTestUnit: AsyncUserInfoRepository!
    let dataToReturn =
"""
{
    "message": "유저 로딩 성공",
    "status": 200,
    "data": {
        "createdAt": "2023-01-23T09:15:07",
        "modifiedAt": "2023-01-23T09:15:07",
        "id": 8,
        "name": "김주원",
        "nickname": "클로이바보",
        "email": "thd930308@naver.com",
        "phoneNumber": "010-7607-8704",
        "type": "BOSS",
        "oauthType": "KAKAO",
        "oauthIdentity": "2596749748",
        "rating": 1,
        "imgPath": null,
    }
}
"""
        .data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let dummyURL = "www.pump.com"

        sucessTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: dummyURL, dataToReturn: dataToReturn)
        )
        failureTestUnit = AsyncUserInfoRepository(
            networkService: MockNetworkService(baseURL: "한글은 안되겠지", dataToReturn: dataToReturn)
        )
    }

    override func tearDownWithError() throws {
        sucessTestUnit = nil
        failureTestUnit = nil
    }

    func test_올바른_baseURL로_fetchProfile_호출시_User를_반환하는지() async throws {
        // given
        do {
            // when
            let fetchProfileResponse = try await sucessTestUnit.fetchProfile()
            // then
            let networkResult = try JSONDecoder().decode(NetworkResult<UserDTO>.self, from: dataToReturn)
            let fetchProfileResult = networkResult.data.toDomain()
            XCTAssertEqual(fetchProfileResponse, fetchProfileResult)
        } catch {
            XCTFail("failed: \(error)")
        }
    }

    func test_잘못된_baseURL로_fetchProfile_호출시_urlParseFailed를_throw_하는지() async throws {
        // given
        do {
            // when
            _ = try await failureTestUnit.fetchProfile()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? RepositoryError, .urlParseFailed)
        }
    }

}
