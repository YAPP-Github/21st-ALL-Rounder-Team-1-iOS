//
//  ProductsTests.swift
//  RefillStationTests
//
//  Created by 천수현 on 2023/02/27.
//

import XCTest
@testable import RefillStation

final class ProductsTests: XCTestCase {

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
            fetchProductsUseCase: MockFetchProductUseCase(products: [
                .init(name: "1", brand: "1", measurement: "", price: 0, imageURL: "", category: .init(title: "1")),
                .init(name: "2", brand: "2", measurement: "", price: 0, imageURL: "", category: .init(title: "2")),
                .init(name: "3", brand: "3", measurement: "", price: 0, imageURL: "", category: .init(title: "3")),
            ]),
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

    func test_전체_카테고리_버튼이_눌렸을때_filteredProducts가_모든_제품을_반환하는지() {
        // given
        // when
        sut.viewDidLoad()
        sut.viewWillAppear()
        while sut.products.isEmpty {}
        sut.categoryButtonDidTapped(category: .all)
        // then
        XCTAssertEqual(
            sut.filteredProducts,
            [
                .init(name: "1", brand: "1", measurement: "", price: 0, imageURL: "", category: .init(title: "1")),
                .init(name: "2", brand: "2", measurement: "", price: 0, imageURL: "", category: .init(title: "2")),
                .init(name: "3", brand: "3", measurement: "", price: 0, imageURL: "", category: .init(title: "3")),
            ]
        )
    }

    func test_전체가_아닌_카테고리_버튼이_눌렸을때_filteredProducts가_currentCategoryFilter에_해당하는_제품만_반환하는지() {
        // given
        // when
        sut.viewDidLoad()
        sut.viewWillAppear()
        while sut.products.isEmpty {}
        sut.categoryButtonDidTapped(category: ProductCategory(title: "2"))
        // then
        XCTAssertEqual(sut.filteredProducts,
                       [Product(name: "2", brand: "2", measurement: "",
                                price: 0, imageURL: "", category: .init(title: "2"))])
    }

    func test_products가_빈배열이면_filteredProducts가_빈배열을_반환하는지() {
        // given
        // when
        // then
        XCTAssertEqual(sut.filteredProducts, [])
    }
}

