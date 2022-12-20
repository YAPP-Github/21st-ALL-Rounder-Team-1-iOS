//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import Foundation
import UIKit

final class HomeViewModel {
    var stores: [Store] = [
        .init(name: "지구샵 제로웨이스트홈",
              address: "서울 마포구 성미산로 155 1층",
              distance: 30,
              phoneNumber: "01012345678",
              snsAddress: "",
              didUserRecommended: true,
              recommendedCount: 10,
              thumbnailImageURL: "",
              imageURL: []),
        .init(name: "지구샵 제로웨이스트홈",
              address: "서울 마포구 성미산로 155 1층",
              distance: 30,
              phoneNumber: "01012345678",
              snsAddress: "",
              didUserRecommended: true,
              recommendedCount: 10,
              thumbnailImageURL: "",
              imageURL: []),
        .init(name: "지구샵 제로웨이스트홈",
              address: "서울 마포구 성미산로 155 1층",
              distance: 30,
              phoneNumber: "01012345678",
              snsAddress: "",
              didUserRecommended: true,
              recommendedCount: 10,
              thumbnailImageURL: "",
              imageURL: [])
    ]
    var isServiceRegion: Bool = false

    var images: [UIImage] = [
    ]
}
