//
//  RegisterReviewCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/20.
//

import UIKit

final class RegisterReviewCoordinator: Coordinator {
    var DIContainer: RegisterReviewDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: RegisterReviewDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
    }
}
