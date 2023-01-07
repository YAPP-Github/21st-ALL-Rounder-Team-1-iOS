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

    private let operationInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("운영정보", for: .normal)
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

    private let operationInfoSelectLine: UIView = {
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
            } else if mode == .reviews {
                setTabForReview()
            } else {
                setTabForOperationInfo()
            }
        }
    }

    var productListButtonTapped: (() -> Void)?
    var reviewButtonTapped: (() -> Void)?
    var operationInfoButtonTapped: (() -> Void)?

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
        operationInfoSelectLine.isHidden = true
        productListButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        reviewButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        operationInfoButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        productListButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        reviewButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        operationInfoButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
    }

    private func setTabForReview() {
        productListSelectLine.isHidden = true
        reviewSelectLine.isHidden = false
        operationInfoSelectLine.isHidden = true
        productListButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        reviewButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        operationInfoButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        productListButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        reviewButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        operationInfoButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
    }

    private func setTabForOperationInfo() {
        productListSelectLine.isHidden = true
        reviewSelectLine.isHidden = true
        operationInfoSelectLine.isHidden = false
        productListButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        reviewButton.titleLabel?.font = UIFont.font(style: .bodyLarge)
        operationInfoButton.titleLabel?.font = UIFont.font(style: .titleMedium)
        productListButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        reviewButton.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        operationInfoButton.setTitleColor(Asset.Colors.gray7.color, for: .normal)
    }

    private func addButtonTargets() {
        productListButton.addAction(UIAction { [weak self] _ in
            self?.productListButtonTapped?()
            self?.mode = .productLists
        }, for: .touchUpInside)

        reviewButton.addAction(UIAction { [weak self] _ in
            self?.reviewButtonTapped?()
            self?.mode = .reviews
        }, for: .touchUpInside)

        operationInfoButton.addAction(UIAction { [weak self] _ in
            self?.operationInfoButtonTapped?()
            self?.mode = .operationInfo
        }, for: .touchUpInside)
    }

    private func layout() {
        [productListButton, reviewButton, divisionLine, productListSelectLine, reviewSelectLine, operationInfoButton, operationInfoSelectLine].forEach {
            addSubview($0)
        }

        productListButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Constraint.headerViewLeadingInset)
            $0.top.bottom.equalToSuperview()
        }

        reviewButton.snp.makeConstraints {
            $0.leading.equalTo(productListSelectLine.snp.trailing).offset(Constraint.tabSpacing)
            $0.top.bottom.equalToSuperview()
        }

        operationInfoButton.snp.makeConstraints {
            $0.leading.equalTo(reviewButton.snp.trailing).offset(Constraint.tabSpacing * 2)
            $0.top.bottom.equalToSuperview()
        }

        divisionLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constraint.divisionLineHeight)
        }

        divisionLine.layer.zPosition = Constraint.divisionLineZPosition

        productListSelectLine.snp.makeConstraints {
            $0.centerX.equalTo(productListButton)
            $0.width.equalTo(productListButton).multipliedBy(Constraint.selectLineMultiplier)
            $0.centerY.equalTo(divisionLine)
            $0.height.equalTo(Constraint.selectLineHeight)
        }

        productListSelectLine.layer.zPosition = Constraint.selectLineZPosition

        reviewSelectLine.snp.makeConstraints {
            $0.centerX.equalTo(reviewButton)
            $0.width.equalTo(reviewButton).multipliedBy(Constraint.selectLineMultiplier)
            $0.centerY.equalTo(divisionLine)
            $0.height.equalTo(Constraint.selectLineHeight)
        }

        reviewSelectLine.layer.zPosition = Constraint.selectLineZPosition

        operationInfoSelectLine.snp.makeConstraints {
            $0.centerX.equalTo(operationInfoButton)
            $0.width.equalTo(operationInfoButton).multipliedBy(Constraint.selectLineMultiplier)
            $0.centerY.equalTo(divisionLine)
            $0.height.equalTo(Constraint.selectLineHeight)
        }

        operationInfoSelectLine.layer.zPosition = Constraint.selectLineZPosition
    }
}

extension StoreDetailHeaderView {
    enum Constraint {
        static let headerViewLeadingInset: CGFloat = 25
        static let tabSpacing: CGFloat = 15
        static let divisionLineZPosition: CGFloat = 0
        static let selectLineZPosition: CGFloat = 1
        static let selectLineHeight: CGFloat = 2
        static let divisionLineHeight: CGFloat = 1
        static let selectLineMultiplier: CGFloat = 1.5
    }
}
