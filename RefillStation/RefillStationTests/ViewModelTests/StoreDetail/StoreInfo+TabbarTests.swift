//
//  StoreInfo+TabbarTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class StoreInfo_TabbarTests: XCTestCase {

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
        sut = StoreDetailViewModel(
            store: storeStub,
            fetchProductsUseCase: MockFetchProductUseCase(products: []),
            fetchStoreReviewsUseCase: MockFetchStoreReviewsUseCase(reviews: []),
            recommendStoreUseCase: MockRecommendStoreUseCase(
                recommendStoreResponseValue: .init(recommendCount: 5, didRecommended: true)
            ),
            fetchStoreRecommendUseCase: MockFetchStoreRecommendUseCase(
                fetchStoreRecommendResponseValue: .init(recommendCount: 4, didRecommended: false)
            )
        )
        sut.viewDidLoad()
        sut.viewWillAppear()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_tabBar_mode_변경시_operationInfoSeeMoreIndexPaths의_원소가_모두_없어지는지() {
        // given
        // when
        sut.mode = .operationInfo
        // then
        XCTAssertTrue(sut.operationInfoSeeMoreIndexPaths.isEmpty)
    }

    func test_좋아요_버튼_누를시_좋아요_개수와_좋아요_누름여부가_갱신되는지() {
        let expectation = XCTestExpectation()
        // given
        // when
        sut.storeLikeButtonTapped()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // then
            XCTAssertEqual(self.sut.store.didUserRecommended, true)
            XCTAssertEqual(self.sut.store.recommendedCount, 5)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
