//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import Foundation

final class HomeViewModel {
    var stores: [Store] = [.init(imageURL: "",
                                 name: "나는 어디",
                                 address: "여긴 누구",
                                 openState: false,
                                 closeTime: "20:00",
                                 distance: 30),
                           .init(imageURL: "",
                                 name: "나는 어디",
                                 address: "여긴 누구",
                                 openState: true,
                                 closeTime: "20:00",
                                 distance: 30)
                           ,.init(imageURL: "",
                                  name: "나는 어디",
                                  address: "여긴 누구",
                                  openState: false,
                                  closeTime: "20:00",
                                  distance: 30),
                           .init(imageURL: "",
                                 name: "나는 어디",
                                 address: "여긴 누구",
                                 openState: true,
                                 closeTime: "20:00",
                                 distance: 30),
                           .init(imageURL: "",
                                 name: "나는 어디",
                                 address: "여긴 누구",
                                 openState: true,
                                 closeTime: "20:00",
                                 distance: 30)]
}
