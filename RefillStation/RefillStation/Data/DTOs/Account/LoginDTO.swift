//
//  LoginDTO.swift
//  RefillStation
//
//  Created by kong on 2023/02/04.
//

import Foundation

struct LoginDTO: Decodable {
    let name, email, imgPath, oauthType, oauthIdentity, jwt, refreshToken: String?
}

extension LoginDTO {
    func toDomain() -> OAuthLoginResponseValue {
        return OAuthLoginResponseValue(name: name,
                                       email: email,
                                       imgPath: imgPath,
                                       oauthIdentity: oauthIdentity ?? "",
                                       oauthType: oauthType ?? "",
                                       jwt: jwt,
                                       refreshToken: refreshToken ?? "")
    }
}
