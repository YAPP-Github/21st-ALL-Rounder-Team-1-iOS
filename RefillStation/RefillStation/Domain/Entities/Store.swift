//
//  Store.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit

struct Store: Hashable {
    let storeId: Int
    let name: String
    let address: String
    let distance: Double
    let phoneNumber: String
    let snsAddress: String
    var didUserRecommended: Bool
    var recommendedCount: Int
    let imageURL: [String]
    let businessHour: [BusinessHour]
    let notice: String
    let storeRefillGuideImagePaths: [String]
}

struct BusinessHour: Hashable {
    enum Day: Int, CaseIterable {
        case sun = 1, mon, tue, wed, thu, fri, sat

        var name: String {
            switch self {
            case .mon:
                return "월"
            case .tue:
                return "화"
            case .wed:
                return "수"
            case .thu:
                return "목"
            case .fri:
                return "금"
            case .sat:
                return "토"
            case .sun:
                return "일"
            }
        }
    }
    let day: Day
    let time: String?
}
