//
//  MyPageDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class MyPageDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService.shared

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func makeMyPageCoordinator() -> MyPageCoordinator {
        return MyPageCoordinator(DIContainer: self,
                                 navigationController: navigationController)
    }

    // MARK: - My Page
    func makeMyPageViewController() -> MyPageViewController {
        return MyPageViewController(viewModel: makeMyPageViewModel())
    }

    func makeMyPageViewModel() -> MyPageViewModel {
        return MyPageViewModel()
    }

    func makeUseCase() {

    }

    func makeMyPageRepository() {
    }
}
