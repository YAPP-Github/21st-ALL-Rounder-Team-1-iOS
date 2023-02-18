//
//  StoreDetailCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class StoreDetailCoordinator: Coordinator {
    let DIContainer: StoreDetailDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: StoreDetailDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        let storeDetailViewController = DIContainer.makeStoreDetailViewController()
        storeDetailViewController.coordinator = self
        navigationController.pushViewController(storeDetailViewController, animated: true)
    }

    func showRegisterReview() {
        let registerReviewDIContainer = DIContainer.makeRegisterReviewDIContainer()
        let registerReviewCoordinator = registerReviewDIContainer.makeRegisterReviewCoordinator()
        registerReviewCoordinator.start()
    }

    func showDetailPhotoReview(photoURLs: [String?]) {
        let detailPhotoReviewViewController = DIContainer.makeDetailPhotoReviewViewController(photoURLs: photoURLs)
        detailPhotoReviewViewController.coodinator = self
        navigationController.pushViewController(detailPhotoReviewViewController, animated: true)
    }

    func refillGuideButtonTapped(imagePaths: [String]) {
        let refillGuideViewController = DIContainer.makeRefillGuideViewController(imagePaths: imagePaths)
        refillGuideViewController.coordinator = self
        refillGuideViewController.modalPresentationStyle = .fullScreen
        navigationController.present(refillGuideViewController, animated: true)
    }

    func refillGuideCloseButtonTapped() {
        navigationController.dismiss(animated: true)
    }

    func popPhotoDetail() {
        navigationController.popViewController(animated: true)
    }
}
