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
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "점원이 친절해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "품목이 다양해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "매장이 청결해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "사장님이 맛있어요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "음식이 친절해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "개발자가 죽어가요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "일정이 빡빡해요"),
                  recommendedCount: 0),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "도움이 필요해요"),
                  recommendedCount: 0)
        ]
        return viewModel
    }
}
