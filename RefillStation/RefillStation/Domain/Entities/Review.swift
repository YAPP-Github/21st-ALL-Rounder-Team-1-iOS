//
//  Review.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation

struct Review: Hashable {
    let userId: Int
    let userNickname: String
    let profileImagePath: String
    let writtenDate: Date
    let imageURL: [String]
    let description: String
    let tags: [Tag]
}
