//
//  SignUpDTO.swift
//  RefillStation
//
//  Created by kong on 2023/02/07.
//

import Foundation

struct SignUpReqeustDTO: Encodable {
    let name: String?
    let email: String?
    let imagePath: String
    let type: String = "USER"
    let oauthType: String
    let oauthIdentity: String
}
