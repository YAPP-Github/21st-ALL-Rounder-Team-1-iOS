//
//  ReviewsTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class ReviewsTests: XCTestCase {

    var sut: StoreDetailViewModel!
    var storeStub = Store(storeId: 1, name: "알맹상점", address: "서울시 송파구", distance: 2.5,
                          phoneNumber: "010-1234-5678", snsAddress: "www.neph3779.github.com",
                          didUserRecommended: false, recommendedCount: 3, imageURL: ["", ""],
                          businessHour: [.init(day: .mon, time: "월요일 10:00 - 17:00"),
                                         .init(day: .tue, time: nil),
                                         .init(day: .wed, time: "수요일 10:00 - 17:00"),
                                         .init(day: .thu, time: "목요일 10:00 - 17:00"),
                                         .init(day: .fri, time: "금요일 10:00 - 17:00"),
                                         .init(day: .sat, time: "토요일 10:00 - 17:00"),
                                         .init(day: .sun, time: nil)
                          ],
                          notice: "", storeRefillGuideImagePaths: ["", ""])
    override func setUpWithError() throws {
        let reviewsStub = [
            Review(userId: 1, userNickname: "Neph", profileImagePath: "",
                   writtenDate: Date(timeIntervalSince1970: 100), imageURL: ["", ""],
                   description: "즐거웠어요", tags: [.canEarnPoint, .clerkIsKind, .storeIsBig]),
            Review(userId: 2, userNickname: "클로이", profileImagePath: "",
                   writtenDate: Date(timeIntervalSince1970: 200), imageURL: ["", ""],
                   description: "재밌어요", tags: [.canEarnPoint, .storeIsBig]),
            Review(userId: 3, userNickname: "조지", profileImagePath: "",
                   writtenDate: Date(timeIntervalSince1970: 300), imageURL: ["", ""],
                   description: "리필해요", tags: [.canEarnPoint]),
            Review(userId: 3, userNickname: "키워드선택안함", profileImagePath: "",
                   writtenDate: Date(timeIntervalSince1970: 400), imageURL: ["", ""],
                   description: "키워드없음", tags: [.noKeywordToChoose]),
            Review(userId: 3, userNickname: "태그가 비어있는 경우", profileImagePath: "",
                   writtenDate: Date(timeIntervalSince1970: 400), imageURL: ["", ""],
                   description: "태그 없음", tags: [])
        ]
        sut = StoreDetailViewModel(
            store: storeStub,
            fetchProductsUseCase: MockFetchProductUseCase(products: []),
            fetchStoreReviewsUseCase: MockFetchStoreReviewsUseCase(reviews: reviewsStub),
            recommendStoreUseCase: MockRecommendStoreUseCase(
                recommendStoreResponseValue: .init(recommendCount: 5, didRecommended: true)
            ),
            fetchStoreRecommendUseCase: MockFetchStoreRecommendUseCase(
                fetchStoreRecommendResponseValue: .init(recommendCount: 4, didRecommended: false)
            )
        )
        self.sut.viewDidLoad()
        self.sut.viewWillAppear()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_totalTagVoteCount가_키워드리뷰가_있는_리뷰수의_합과_같은지() async {
        // given
        // when
        // then
        XCTAssertEqual(sut.totalTagVoteCount, 3)
    }

    func test_rankTag가_키워드리뷰의_전체목록을_투표수_내림차순과_이름_오름차순으로_담고있는지() async {
        // given
        // when
        // then
        XCTAssertEqual(sut.rankTags,
                       [
                        .init(tag: .canEarnPoint, voteCount: 3),
                        .init(tag: .storeIsBig, voteCount: 2),
                        .init(tag: .clerkIsKind, voteCount: 1),
                        .init(tag: .priceIsReasonable, voteCount: 0),
                        .init(tag: .storeIsClean, voteCount: 0),
                        .init(tag: .veryAccessible, voteCount: 0),
                        .init(tag: .variousItems, voteCount: 0)
                       ])
    }

    func test_리뷰셀의_더보기_버튼이_눌렸을때_셀의_indexPath가_reviewSeeMoreIndexPaths에_추가되는지() {
        sut.reviewSeeMoreTapped(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(sut.reviewSeeMoreIndexPaths, [IndexPath(row: 0, section: 0)])
    }
}
