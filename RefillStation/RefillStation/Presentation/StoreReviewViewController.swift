//
//  StoreReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit

final class StoreReviewViewController: UIViewController {

    private let moveToWritingReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("방문하셨다면 리뷰를 남겨주세요! ✏️", for: .normal)
        return button
    }()

    private var tagReviewView: TagReviewView!
    private var detailReviewTableView: DetailReviewTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func initailizeViews() {

    }

    private func layout() {

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
