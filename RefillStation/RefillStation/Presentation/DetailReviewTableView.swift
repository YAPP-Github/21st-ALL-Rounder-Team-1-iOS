//
//  DetailReviewTableView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit

final class DetailReviewTableView: UITableView {

    var viewModel: DetailReviewViewModel

    init(viewModel: DetailReviewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        register(DetailReviewTableViewCell.self,
                 forCellReuseIdentifier: DetailReviewTableViewCell.reuseIdentifier)
        dataSource = self
    }

    required init?(coder: NSCoder) {
        self.viewModel = DetailReviewViewModel()
        super.init(coder: coder)
    }

}

// MARK: - UITableViewDataSource

extension DetailReviewTableView: UITableViewDataSource {
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
