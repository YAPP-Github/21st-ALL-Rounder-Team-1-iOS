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
    private let reviewWritingViewController = ReviewWritingViewController()
    private lazy var tabViewControllers = [storeReviewViewController, reviewWritingViewController]

    private let storeDetailInfoView: StoreDetailInfoView = {
        let viewModel = StoreDetailViewModel()
        return StoreDetailInfoView(viewModel: viewModel)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        storeReviewViewController.tabViewDelegate = self
        tabmanViewController.dataSource = self
        layout()

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
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
        return tabViewControllers.count
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
        return TMBarItem(title: index.description)
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
