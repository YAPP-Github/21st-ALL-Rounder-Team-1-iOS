//
//  StoreDetailTabViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit
import Tabman
import Pageboy

final class StoreDetailTabViewController: UIViewController {
    lazy var tabmanViewController = TabmanViewController()
    private let storeReviewViewController = StoreReviewViewController()
    private let productListViewController = ProductListViewController()
    private lazy var tabViewControllers = [productListViewController, storeReviewViewController]

    private let storeDetailInfoView: StoreDetailInfoView = {
        let viewModel = StoreDetailViewModel()
        return StoreDetailInfoView(viewModel: viewModel)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpDelegate()
        setUpTabman()
        layout()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = ""
    }

    private func setUpDelegate() {
        storeReviewViewController.tabViewDelegate = self
        productListViewController.tabViewDelegate = self
    }

    private func setUpTabman() {
        tabmanViewController.dataSource = self
        tabmanViewController.isScrollEnabled = false

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tabmanViewController.addBar(bar, dataSource: self, at: .top)
    }

    private func layout() {
        addChild(tabmanViewController)
        [storeDetailInfoView, tabmanViewController.view].forEach {
            view.addSubview($0)
        }

        storeDetailInfoView.snp.makeConstraints { infoView in
            infoView.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tabmanViewController.view.snp.makeConstraints { tabman in
            tabman.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            tabman.top.equalTo(storeDetailInfoView.snp.bottom)
        }
    }
}

extension StoreDetailTabViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return Section.allCases.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return tabViewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

extension StoreDetailTabViewController: TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        guard let title = Section(rawValue: index)?.title else { return TMBarItem(title: "") }
        return TMBarItem(title: title)
    }
}

extension StoreDetailTabViewController: TabViewDelegate {
    func scrollViewDidScroll(offset: CGPoint) {

        storeDetailInfoView.snp.remakeConstraints { infoView in
            infoView.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-offset.y)
            infoView.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        view.layoutSubviews()
    }
}

extension StoreDetailTabViewController {
    enum Section: Int, CaseIterable {
        case products
        case reviews

        var title: String {
            switch self {
            case .products:
                return "판매상품"
            case .reviews:
                return "리뷰"
            }
        }
    }
}
