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

    var products: [Product] = [.init(name: "로즈마리 솔트 스크럽 샴푸",
                                     brand: "아로마티카",
                                     pricePerGram: 24,
                                     imageURL: ""),
                               .init(name: "티트리 퓨리파잉 샴푸",
                                     brand: "아로마티카",
                                     pricePerGram: 16,
                                     imageURL: ""),
                               .init(name: "시어버터 바디워시",
                                     brand: "해피바스",
                                     pricePerGram: 32,
                                     imageURL: ""),
                               .init(name: "오가니스트 아르간 영양샴푸",
                                     brand: "LG 생활건강",
                                     pricePerGram: 19,
                                     imageURL: "")]
}
