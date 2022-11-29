//
//  ProductDetailViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    private var productTableView: ProductTableView!
    private var storeDetailViewModel: StoreDetailViewModel!
    weak var tabViewDelegate: TabViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        layout()
    }

    private func layout() {
        view.addSubview(productTableView)

        productTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setUpTableView() {
        storeDetailViewModel = StoreDetailViewModel()
        productTableView = ProductTableView(viewModel: storeDetailViewModel)
        productTableView.showsVerticalScrollIndicator = false
        productTableView.delegate = self
        productTableView.bounces = false
    }
}

extension ProductDetailViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabViewDelegate?.scrollViewDidScroll(offset: scrollView.contentOffset)
    }
}
