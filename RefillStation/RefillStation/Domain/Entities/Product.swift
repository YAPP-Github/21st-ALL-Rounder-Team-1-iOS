//
//  Product.swift
//  RefillStation
//
//  Created by kong on 2022/11/27.
//

import Foundation

struct Product: Hashable {
    let name: String
    let brand: String
    let measurement: String
    let price: Int
    let imageURL: String
    let category: ProductCategory
}
