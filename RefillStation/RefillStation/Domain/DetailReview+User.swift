//
//  DetailReview.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import Foundation
struct DetailReview {

    let user: User
    let writtenDate: Date
    let imageURLs: [String]
    let description: String

    struct User {
        let name: String
        let profileImageURL: String
    }
}
