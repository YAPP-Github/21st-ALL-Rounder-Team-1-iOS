//
//  CustomerSatisfactionDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/08.
//

import Foundation

struct CustomerSatisfactionDTO: Encodable {
    let userId: Int
    let type: Int
    let content: String
}

struct CustomerSatisfactionResponseDTO: Decodable {
    let customerSatisfactionId: Int
}
