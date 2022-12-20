//
//  ProductListViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

final class ProductListViewController: UIViewController {

    private var productTableView: ProductTableView!
    private var productListViewModel: ProductListViewModel!
    weak var tabViewDelegate: TabViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        layout()
    }

    private func layout() {
        view.addSubview(productTableView)

        productTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    private func setUpTableView() {
        productListViewModel = ProductListViewModel()
        productTableView = ProductTableView(viewModel: productListViewModel)
        productTableView.showsVerticalScrollIndicator = false
        productTableView.delegate = self
        productTableView.bounces = false
    }
}

extension ProductListViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabViewDelegate?.scrollViewDidScroll(offset: scrollView.contentOffset)
    }
}
