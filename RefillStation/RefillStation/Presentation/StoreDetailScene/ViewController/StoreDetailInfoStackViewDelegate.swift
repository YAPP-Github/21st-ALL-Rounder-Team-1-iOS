//
//  StoreDetailViewControllerExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/01.
//

import UIKit

protocol StoreDetailInfoStackViewDelegate: AnyObject { // TODO: 클로저에 줄때 enum 케이스 줘서 분기처리
    func callButtonTapped()
    func storeLinkButtonTapped()
    func recommendButtonTapped()
}
