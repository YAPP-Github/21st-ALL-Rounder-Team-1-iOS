//
//  StoreReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreReviewViewController: UIViewController {

    private let moveToWritingReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("방문하셨다면 리뷰를 남겨주세요! ✏️", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
        return button
    }()

    private var tagReviewView: TagReviewView!
    private var detailReviewTableView: DetailReviewTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initailizeViews()
        layout()
        addMoveToWritingReviewButtonTarget()
    }

    private func initailizeViews() {
        let mockTagReviewViewModel: TagReviewViewModel = {
            let viewModel = TagReviewViewModel()
            viewModel.totalVoteCount = 10
            viewModel.tagReviews = [
                .init(tagTitle: "청결해요", voteCount: 5),
                .init(tagTitle: "친절해요", voteCount: 6),
                .init(tagTitle: "배고파요", voteCount: 7),
                .init(tagTitle: "살려줘요", voteCount: 8)
            ]
            return viewModel
        }()

        let mockDetailReviewViewModel: DetailReviewViewModel = {
            let viewModel = DetailReviewViewModel()
            viewModel.detailReviews = [
                .init(user: .init(name: "", profileImageURL: ""),
                      writtenDate: Date(),
                      imageURLs: [],
                      description: "description"),
                .init(user: .init(name: "", profileImageURL: ""),
                      writtenDate: Date(),
                      imageURLs: [],
                      description: "description"),
                .init(user: .init(name: "", profileImageURL: ""),
                      writtenDate: Date(),
                      imageURLs: [],
                      description: "description"),
                .init(user: .init(name: "", profileImageURL: ""),
                      writtenDate: Date(),
                      imageURLs: [],
                      description: "description")
            ]
            return viewModel
        }()
        tagReviewView = TagReviewView(viewModel: mockTagReviewViewModel)
        detailReviewTableView = DetailReviewTableView(viewModel: mockDetailReviewViewModel)
    }

    private func layout() {
        [moveToWritingReviewButton, tagReviewView, detailReviewTableView].forEach { view.addSubview($0) }

        moveToWritingReviewButton.snp.makeConstraints { button in
            button.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        tagReviewView.snp.makeConstraints { reviewView in
            reviewView.top.equalTo(moveToWritingReviewButton.snp.bottom).offset(10)
            reviewView.leading.trailing.equalTo(view).inset(10)
            reviewView.height.equalTo(300)
        }

        detailReviewTableView.snp.makeConstraints { table in
            table.top.equalTo(tagReviewView.snp.bottom).offset(10)
            table.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    private func addMoveToWritingReviewButtonTarget() {
        moveToWritingReviewButton.addTarget(self,
                                            action: #selector(moveToWritingReviewButtonTapped(_:)),
                                            for: .touchUpInside)
    }

    @objc
    private func moveToWritingReviewButtonTapped(_ sender: UIButton) {

    }
}
