//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import Foundation
import UIKit

final class HomeViewModel {
    var stores: [Store] = MockEntityData.stores()
    var isServiceRegion: Bool = false

    var images: [UIImage] = [
    ]
}
