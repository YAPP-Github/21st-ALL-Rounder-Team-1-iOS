//
//  Exception.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

struct Exception: Decodable {
    let timeStamp: String
    let status: Int
    let error: String
    let message: String
    let path: String
}
