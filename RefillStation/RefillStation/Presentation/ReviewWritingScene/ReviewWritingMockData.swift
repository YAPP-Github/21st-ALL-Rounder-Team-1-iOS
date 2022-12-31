//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import Foundation
import UIKit

extension ReviewWritingViewController {
    func makeMockViewModel() -> DefaultTagReviewViewModel {
        let viewModel = DefaultTagReviewViewModel()
        viewModel.reviews = [
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "포인트 적립이 가능해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "품목이 다양해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "점원이 친절해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "위치 접근성이 좋아요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "가격이 합리적이에요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "매장이 커요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "매장이 청결해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "선택할 키워드가 없어요"),
                  recommendedCount: 0)
        ]
        return viewModel
    }
}
