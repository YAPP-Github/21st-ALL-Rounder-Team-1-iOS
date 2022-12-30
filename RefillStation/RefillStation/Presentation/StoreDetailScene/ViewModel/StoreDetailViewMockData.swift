//
//  StoreDetailViewMockData.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

extension HomeViewController {
    func makeMockDetailReviewViewModel() -> DetailReviewViewModel {
        let viewModel = DetailReviewViewModel()
        viewModel.detailReviews = [
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", tags: [.init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그"), recommendedCount: 0), .init(tag: .init(image: UIImage(), title: "이런태그 저런태그 어쩌구 저쩌구"), recommendedCount: 0)]),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description", tags: []),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description", tags: []),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description", tags: []),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description", tags: [])
        ]
        return viewModel
    }

    func makeMockVoteTagViewModel() -> VotedTagViewModel {
        let viewModel = VotedTagViewModel()
        viewModel.totalVoteCount = 2
        viewModel.tagReviews = [
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "친절해요"),
                  recommendedCount: 3),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "청결해요"),
                  recommendedCount: 4),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "배고파요"),
                  recommendedCount: 5),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "살려줘요"),
                  recommendedCount: 6)
        ]

        return viewModel
    }
}
