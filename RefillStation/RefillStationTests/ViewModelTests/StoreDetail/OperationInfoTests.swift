//
//  OperationInfoTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class OperationInfoTests: XCTestCase {

    var sut: StoreDetailViewModel!
    var storeStub = Store(storeId: 1, name: "알맹상점", address: "서울시 송파구", distance: 2.5,
                          phoneNumber: "010-1234-5678", snsAddress: "www.neph3779.github.com",
                          didUserRecommended: false, recommendedCount: 3, imageURL: ["", ""],
                          businessHour: [.init(day: .mon, time: "10:00 - 17:00"),
                                         .init(day: .tue, time: nil),
                                         .init(day: .wed, time: "10:00 - 17:00"),
                                         .init(day: .thu, time: "10:00 - 17:00"),
                                         .init(day: .fri, time: "10:00 - 17:00"),
                                         .init(day: .sat, time: "10:00 - 17:00"),
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

    func test_operationInfoCell의_더보기_버튼이_눌렸을때_셀의_indexPath가_reviewSeeMoreIndexPaths에_추가되는지() {
        // given
        // when
        sut.operationInfoSeeMoreTapped(indexPath: IndexPath(row: 0, section: 0))
        // then
        XCTAssertEqual(sut.operationInfoSeeMoreIndexPaths, [IndexPath(row: 0, section: 0)])
    }

    func test_store의_정보가_operationInfo_배열로_formatting되는지() {
        // given
        // when
        // then
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        let today = dateFormatter.string(from: Date())
        let todayInfo: String = {
            if let today = sut.store.businessHour.filter({ $0.day.name == today }).first {
                return "\(today.day.name) \(today.time ?? "정기 휴무일") \n\n"
            }
            return ""
        }()

        let businessHourInfo = todayInfo
        + sut.store.businessHour
            .filter { $0.day.name != today }
            .sorted {
                return $0.day.rawValue < $1.day.rawValue
            }
            .reduce(into: "") { partialResult, businessHour in
                partialResult += "\(businessHour.day.name) \(businessHour.time ?? "정기 휴무일") \n"
            }
        + (!(sut.store.businessHour.isEmpty || sut.store.notice.isEmpty) ? "\n" : "")
        + sut.store.notice

        let time = businessHourInfo
        XCTAssertEqual(sut.operationInfos, [
            .init(type: .time, content: businessHourInfo),
            .init(type: .phoneNumber, content: "010-1234-5678"),
            .init(type: .link, content: "www.neph3779.github.com"),
            .init(type: .address, content: "서울시 송파구")
        ])
    }
}
