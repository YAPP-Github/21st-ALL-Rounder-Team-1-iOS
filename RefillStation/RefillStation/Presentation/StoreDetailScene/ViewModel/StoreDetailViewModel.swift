//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import Foundation

final class StoreDetailViewModel {
    var name: String = "알맹 상점"
    var reviewCount: Int = 1018
    var address: String = "서울시 성북구 삼선동"
    var openState: Bool = true
    var closeTime: String = "8:00"

    var products: [Product] = [.init(name: "스킨",
                                     brand: "아로마티카",
                                     pricePerGram: 123,
                                     imageURL: ""),
                               .init(name: "로션",
                                     brand: "아로마티카",
                                     pricePerGram: 423,
                                     imageURL: ""),
                               .init(name: "바디오일",
                                     brand: "아로마티카",
                                     pricePerGram: 2435,
                                     imageURL: ""),
                               .init(name: "샴푸",
                                     brand: "아로마티카",
                                     pricePerGram: 1241,
                                     imageURL: "")]
}
