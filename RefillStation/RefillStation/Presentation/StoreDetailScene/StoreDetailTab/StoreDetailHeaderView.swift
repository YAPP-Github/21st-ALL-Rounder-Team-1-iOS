//
//  StoreDetailHeaderView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "storeDetailHeaderView"

    private let productListButton: UIButton = {
        let button = UIButton()
        button.setTitle("판매상품", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.titleLabel?.font = UIFont.font(style: .bodyLarge)
        return button
    }()

    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.titleLabel?.font = UIFont.font(style: .bodyLarge)
        return button
    }()

    private let productListSelectLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray7.color
        return line
    }()

    private let reviewSelectLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray7.color
        return line
    }()

    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    private var mode: StoreDetailViewModel.Mode = .productLists {
        didSet {
            if mode == .productLists {
                setTabForProductList()
            } else {
                setTabForReview()
            }
        }
    }

    var productListButtonTapped: (() -> Void)?
    var reviewButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        addButtonTargets()
        setTabForProductList()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setTabForProductList() {
        productListSelectLine.isHidden = false
        reviewSelectLine.isHidden = true
        productListButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        reviewButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        productListButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        reviewButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
    }

    private func setTabForReview() {
        productListSelectLine.isHidden = true
        reviewSelectLine.isHidden = false
        productListButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        reviewButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        productListButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        reviewButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
    }

    private func addButtonTargets() {
        productListButton.addTarget(self, action: #selector(productListButtonTapped(_:)), for: .touchUpInside)
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped(_:)), for: .touchUpInside)
    }

    private func layout() {
        [productListButton, reviewButton, divisionLine, productListSelectLine, reviewSelectLine].forEach {
            addSubview($0)
        }

        productListButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview()
        }

        reviewButton.snp.makeConstraints {
            $0.leading.equalTo(productListSelectLine.snp.trailing).offset(15)
            $0.top.bottom.equalToSuperview()
        }

        divisionLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(2.5)
            $0.height.equalTo(1)
        }

        divisionLine.layer.zPosition = 0

        productListSelectLine.snp.makeConstraints {
            $0.centerX.equalTo(productListButton)
            $0.width.equalTo(productListButton).multipliedBy(1.5)
            $0.centerY.equalTo(divisionLine)
            $0.height.equalTo(2)
        }

        productListSelectLine.layer.zPosition = 1

        reviewSelectLine.snp.makeConstraints {
            $0.centerX.equalTo(reviewButton)
            $0.width.equalTo(reviewButton).multipliedBy(1.5)
            $0.centerY.equalTo(divisionLine)
            $0.height.equalTo(2)
        }

        reviewSelectLine.layer.zPosition = 1
    }

    @objc
    private func productListButtonTapped(_ sender: UIButton) {
        productListButtonTapped?()
        mode = .productLists
    }

    @objc
    private func reviewButtonTapped(_ sender: UIButton) {
        reviewButtonTapped?()
        mode = .reviews
    }
}
