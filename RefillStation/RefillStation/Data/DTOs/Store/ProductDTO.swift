//
//  ProductDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/04.
//

import Foundation

struct ProductDTO: Decodable {
    let createdAt: String?
    let modifiedAt: String?
    let id: Int?
    let storeId: Int?
    let title: String?
    let price: Double?
    let unit: String?
    let brand: String?
    let category: String?
    let imgPath: String?
    let isHided: Bool?
    let isReady: Bool?
}

extension ProductDTO {
    func toDomain() -> Product {
        return Product(
            name: title ?? "",
            brand: brand ?? "",
            measurement: unit ?? "",
            price: Int(price ?? 0),
            imageURL: imgPath ?? "",
            category: .init(title: category ?? ""))
    }
}
