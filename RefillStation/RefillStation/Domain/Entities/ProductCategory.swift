//
//  ProductCategory.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import Foundation

struct ProductCategory: Hashable {
    static let all = ProductCategory(title: "전체")
    let title: String
}
