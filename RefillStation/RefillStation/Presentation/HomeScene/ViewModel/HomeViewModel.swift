//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import Foundation
import UIKit

final class HomeViewModel {
    var stores: [Store] = [.init(imageURL: "",
                                 name: "지구샵 제로웨이스트홈",
                                 address: "서울 마포구 성미산로 155 1층",
                                 openState: false,
                                 closeTime: "21:30",
                                 distance: 30),
                           .init(imageURL: "",
                                 name: "영그램",
                                 address: "서울 마포구 월드컵로 240 홈플러스 월드컵점 2층",
                                 openState: true,
                                 closeTime: "21:00",
                                 distance: 30),
                           .init(imageURL: "",
                                  name: "어쩌다에코",
                                  address: "서울 영등포구 양평로28마길 7 와일드와일드웨스트 매장 내 2층",
                                  openState: false,
                                  closeTime: "20:00",
                                  distance: 30),
                           .init(imageURL: "",
                                 name: "알맹상점",
                                 address: "서울 마포구 월드컵로25길 47 3층 알맹상점",
                                 openState: true,
                                 closeTime: "22:00",
                                 distance: 30)]
    var isServiceRegion: Bool = false

    var images: [UIImage] = [
    ]
}
