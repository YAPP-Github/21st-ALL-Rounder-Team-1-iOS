//
//  MockData.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

extension StoreReviewViewController {
    func makeMockDetailReviewViewModel() -> DetailReviewViewModel {
        let viewModel = DetailReviewViewModel()
        viewModel.detailReviews = [
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description"),
            .init(user: .init(name: "hello", profileImageURL: ""),
                  writtenDate: Date(),
                  imageURLs: [],
                  description: "description")
        ]

        return viewModel
    }

    func makeMockVoteTagViewModel() -> VotedTagViewModel {
        let viewModel = VotedTagViewModel()
        viewModel.totalVoteCount = 2
        viewModel.tagReviews = [
            .init(tagTitle: "친절해요", voteCount: 3, image: UIImage(systemName: "zzz")),
            .init(tagTitle: "청결해요", voteCount: 4, image: UIImage(systemName: "zzz")),
            .init(tagTitle: "배고파요", voteCount: 5, image: UIImage(systemName: "zzz")),
            .init(tagTitle: "살려줘요", voteCount: 6, image: UIImage(systemName: "zzz"))
        ]

        return viewModel
    }
}
