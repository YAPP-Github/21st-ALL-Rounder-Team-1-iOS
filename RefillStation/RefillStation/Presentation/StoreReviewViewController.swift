//
//  StoreReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit
import SnapKit

final class StoreReviewViewController: UIViewController {

    private var viewModel = DetailReviewViewModel()

    private let moveToWritingReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("방문하셨다면 리뷰를 남겨주세요! ✏️", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
        return button
    }()

    private var detailReviewTableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initailizeViews()
        setUpDetailReviewTableView()
        layout()
        addMoveToWritingReviewButtonTarget()
    }

    override func viewDidLayoutSubviews() {
        detailReviewTableView.sectionHeaderHeight = 230
    }

    private func setUpDetailReviewTableView() {
        detailReviewTableView.register(DetailReviewTableViewCell.self,
                 forCellReuseIdentifier: DetailReviewTableViewCell.reuseIdentifier)
        detailReviewTableView.register(DetailReviewTableViewHeader.self,
                                       forHeaderFooterViewReuseIdentifier: DetailReviewTableViewHeader.reuseIdentifier)
        detailReviewTableView.dataSource = self
        detailReviewTableView.delegate = self
        detailReviewTableView.allowsSelection = false
    }

    private func initailizeViews() {
        let mockDetailReviewViewModel: DetailReviewViewModel = {
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
        }()
        viewModel = mockDetailReviewViewModel
    }

    private func layout() {
        [moveToWritingReviewButton, detailReviewTableView].forEach {
            view.addSubview($0)
        }

        moveToWritingReviewButton.snp.makeConstraints { button in
            button.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        detailReviewTableView.snp.makeConstraints { table in
            table.top.equalTo(moveToWritingReviewButton.snp.bottom).offset(10)
            table.leading.trailing.bottom.equalTo(view)
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

extension StoreReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailReviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailReviewTableViewCell.reuseIdentifier,
            for: indexPath) as? DetailReviewTableViewCell else {
            return UITableViewCell()
        }

        cell.setUpContents(detailReview: viewModel.detailReviews[indexPath.row])
        return cell
    }
}

extension StoreReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: DetailReviewTableViewHeader.reuseIdentifier) as? DetailReviewTableViewHeader else {
            return UIView()
        }
        headerView.sizeToFit()
        return headerView
    }
}
