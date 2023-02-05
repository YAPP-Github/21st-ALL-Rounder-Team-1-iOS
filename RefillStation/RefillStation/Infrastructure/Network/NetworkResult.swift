//
//  NetworkResult.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

struct NetworkResult<DTO: Decodable>: Decodable {
    let message: String
    let status: Int
    let data: DTO
}
