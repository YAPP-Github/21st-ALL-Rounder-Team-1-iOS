//
//  StoreInfoViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/04.
//

import UIKit

final class StoreDetailInfoViewModel {
    var name: String = "알맹 상점"
    var reviewCount: Int = 1018
    var address: String = "서울시 성북구 삼선동"
    var openState: Bool = true
    var closeTime: String = "8:00"
    var phoneNumber: String = "0212345678"
    var storeLink: URL? = URL(string: "https://naver.com")

    enum ButtonType {
        case phone
        case link
        case like

        var image: UIImage? {
            switch self {
            case .phone:
                return UIImage(systemName: "phone")
            case .link:
                return UIImage(systemName: "link")
            case .like:
                return UIImage(systemName: "hand.thumbsup")
            }
        }

        var title: String {
            switch self {
            case .phone:
                return "전화"
            case .link:
                return "매장"
            case .like:
                return "추천"
            }
        }
    }
}
