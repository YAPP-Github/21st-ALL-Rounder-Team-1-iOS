//
//  Tag.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import UIKit

struct Tag: Hashable {
    let id: Int
    let image: UIImage
    let title: String
}

enum PumpTags: Int, CaseIterable {
    case canEarnPoint = 1
    case variousItems
    case clerkIsKind
    case veryAccessible
    case priceIsReasonable
    case storeIsBig
    case storeIsClean
    case noKeywordToChoose

    var image: UIImage {
        switch self {
        case .canEarnPoint:
            return Asset.Images.imgKeywordPoint.image
        case .variousItems:
            return Asset.Images.imgKeywordProduct.image
        case .clerkIsKind:
            return Asset.Images.imgKeywordKind.image
        case .veryAccessible:
            return Asset.Images.imgKeywordPosition.image
        case .priceIsReasonable:
            return Asset.Images.imgKeywordPrice.image
        case .storeIsBig:
            return Asset.Images.imgKeywordStore.image
        case .storeIsClean:
            return Asset.Images.imgKeywordClean.image
        case .noKeywordToChoose:
            return Asset.Images.imgKeywordX.image
        }
    }

    var text: String {
        switch self {
        case .canEarnPoint:
            return "포인트 적립이 가능해요"
        case .variousItems:
            return "품목이 다양해요"
        case .clerkIsKind:
            return "점원이 친절해요"
        case .veryAccessible:
            return "위치 접근성이 좋아요"
        case .priceIsReasonable:
            return "가격이 합리적이에요"
        case .storeIsBig:
            return "매장이 커요"
        case .storeIsClean:
            return "매장이 청결해요"
        case .noKeywordToChoose:
            return "선택할 키워드가 없어요"
        }
    }
}
