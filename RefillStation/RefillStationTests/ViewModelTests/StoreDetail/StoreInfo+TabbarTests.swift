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
}
