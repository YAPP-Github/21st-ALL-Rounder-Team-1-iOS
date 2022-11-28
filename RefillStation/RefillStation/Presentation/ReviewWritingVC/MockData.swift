//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import Foundation

extension ReviewWritingViewController {
    func makeMockViewModel() -> DefaultTagReviewViewModel {
        let viewModel = DefaultTagReviewViewModel()
        viewModel.reviews = [
            .init(tagTitle: "점원이 친절해요", voteCount: 0),
            .init(tagTitle: "품목이 다양해요", voteCount: 0),
            .init(tagTitle: "매장이 청결해요", voteCount: 0),
            .init(tagTitle: "사장님이 맛있어요", voteCount: 0),
            .init(tagTitle: "음식이 친절해요", voteCount: 0),
            .init(tagTitle: "개발자가 죽어가요", voteCount: 0),
            .init(tagTitle: "일정이 빡빡해요", voteCount: 0),
            .init(tagTitle: "도움이 필요해요", voteCount: 0)
        ]
        return viewModel
    }
}
