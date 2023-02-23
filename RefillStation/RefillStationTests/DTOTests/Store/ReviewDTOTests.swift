//
//  ReviewDTOTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/23.
//

import XCTest
@testable import RefillStation

final class ReviewDTOTests: XCTestCase {
    var fullContentUnit: ReviewDTO!
    var minimumContentUnit: ReviewDTO!

    override func setUpWithError() throws {
        fullContentUnit = ReviewDTO(id: 1, storeId: 1, userId: 1, reviewText: "reviewText", createdAt: "2023-01-29T18:56:24", modifiedAt: "modifiedAt", user: .init(createdAt: "createdAt", modifiedAt: "modifiedAt", id: 1, name: "name", nickname: "nickname", email: "email", phoneNumber: "phoneNumber", type: "type", oauthType: "oauthType", oauthIdentity: "oauthIdentity", rating: 1, imgPath: "imgPath", removedAt: "removedAt"), imgReviews: [.init(createdAt: "createdAt", modifiedAt: "modifiedAt", id: 1, reviewId: 1, path: "path")], reviewTagLogs: [.init(createdAt: "createdAt", modifiedAt: "modifiedAt", id: 1, reviewId: 1, userId: 1, storeId: 1, reviewTagId: -1), .init(createdAt: "createdAt", modifiedAt: "modifiedAt", id: 1, reviewId: 1, userId: 1, storeId: 1, reviewTagId: nil)])

        minimumContentUnit = ReviewDTO(id: nil, storeId: nil, userId: nil, reviewText: nil, createdAt: "2023-01-29T18:56:24", modifiedAt: nil, user: nil, imgReviews: nil, reviewTagLogs: nil)
    }

    override func tearDownWithError() throws {
        fullContentUnit = nil
        minimumContentUnit = nil
    }

    func test_모든_필드가_채워진_ReviewDTO의_toDomain_메서드를_호출하면_모든_필드가_채워진_Review를_반환하는지() {
        // given
        // when
        let domainResult = fullContentUnit.toDomain()
        // then
        let expectationResult = Review(userId: 1, userNickname: "nickname", profileImagePath: "imgPath", writtenDate: "2023-01-29T18:56:24".toDate()!, imageURL: ["path"], description: "reviewText", tags: [.noKeywordToChoose, .noKeywordToChoose])
        XCTAssertEqual(domainResult, expectationResult)
    }

    func test_최소한의_필드만_채워진_ReviewDTO의_toDomain_메서드를_호출하면_기본값으로_채워진_Review를_반환하는지() {
        // given
        // when
        let domainResult = minimumContentUnit.toDomain()
        // then
        let expectationResult = Review(userId: 0, userNickname: "", profileImagePath: "", writtenDate: "2023-01-29T18:56:24".toDate()!, imageURL: [], description: "", tags: [])
        XCTAssertEqual(domainResult, expectationResult)
    }
}

fileprivate extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // "2023-02-07T14:22:26"
        let dateString = dateFormatter.date(from: self)
        return dateString
    }
}
