//
//  ProductTableView.swift
//  RefillStation
//
//  Created by kong on 2022/11/26.
//

import UIKit
import SnapKit

final class ProductTableView: UITableView {

    private var viewModel: ProductListViewModel!

    // MARK: - Initializer
    convenience init(viewModel: ProductListViewModel) {
        self.init()
        self.viewModel = viewModel
        register(ProductTableViewCell.self,
                 forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        dataSource = self
    }
}

// MARK: - Extensions
extension ProductTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.reuseIdentifier,
            for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let data = viewModel.products[indexPath.row]
        cell.render()
        cell.setUpContents(productName: data.name,
                           imageURL: data.imageURL,
                           brand: data.brand,
                           price: data.pricePerGram)
        return cell
    }
}
