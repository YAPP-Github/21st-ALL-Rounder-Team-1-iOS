//
//  RefillGuideViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/18.
//

import UIKit

final class RefillGuideViewController: UIViewController {

    var coordinator: StoreDetailCoordinator?
    private let viewModel: RefillGuideViewModel

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconClose.image, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.coordinator?.refillGuideCloseButtonTapped()
        }, for: .touchUpInside)
        return button
    }()
    private lazy var titleBar: UIView = {
        let titleBar = UIView()
        titleBar.backgroundColor = .white
        titleBar.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(24)
        }
        return titleBar
    }()
    private let outerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()

    init(viewModel: RefillGuideViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    private func layout() {
        [titleBar, outerScrollView].forEach { view.addSubview($0) }
        titleBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        outerScrollView.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom)
            $0.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        outerScrollView.addSubview(imageStackView)
        imageStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
