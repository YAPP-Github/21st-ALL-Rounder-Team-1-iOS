//
//  EditProfileUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

struct EditProfileRequestValue {
  let name: String
  let nickname: String
  let email: String
  let phoneNumber: String
  let type: String
  let oauthType: String
  let oauthIdentity: String
  let rating: Int
  let imgPath: String
}
