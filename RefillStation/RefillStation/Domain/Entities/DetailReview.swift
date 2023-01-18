//
//  DetailReview.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import Foundation

struct DetailReview: Hashable {
    let user: User
    let writtenDate: Date
    let imageURL: [String?]
    let description: String
    let tags: [TagReview]
}
