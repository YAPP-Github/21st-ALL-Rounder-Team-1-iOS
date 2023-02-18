//
//  RefillGuideViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/18.
//

import UIKit

final class RefillGuideViewController: UIViewController {

    private let viewModel: RefillGuideViewModel

    init(viewModel: RefillGuideViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
