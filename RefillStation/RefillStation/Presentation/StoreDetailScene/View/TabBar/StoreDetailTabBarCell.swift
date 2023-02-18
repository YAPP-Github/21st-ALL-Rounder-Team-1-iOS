//
//  StoreDetailTabBarCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/14.
//

import UIKit

final class StoreDetailTabBarCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: StoreDetailTabBarCell.self)

    private let productListButton: UIButton = {
        let button = UIButton()
        button.setTitle("판매상품", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.titleLabel?.font = .font(style: .bodyLarge)
        return button
    }()

    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.titleLabel?.font = .font(style: .bodyLarge)
        return button
    }()

    private let operationInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("운영정보", for: .normal)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
        button.titleLabel?.font = .font(style: .bodyLarge)
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

    private var mode: StoreDetailViewModel.TabBarMode = .productLists

    var headerTapped: ((StoreDetailViewModel.TabBarMode) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
        addButtonTargets()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(mode: StoreDetailViewModel.TabBarMode) {
        removeSelected()
        self.mode = mode
        setTabAppearance(for: mode)
    }

    private func removeSelected() {
        [productListSelectLine, reviewSelectLine, operationInfoSelectLine].forEach {
            $0.isHidden = true
        }
        [productListButton, reviewButton, operationInfoButton].forEach {
            $0.titleLabel?.font = .font(style: .bodyLarge)
            $0.setTitleColor(Asset.Colors.gray4.color, for: .normal)
        }
    }

    private func setTabAppearance(for tabBarMode: StoreDetailViewModel.TabBarMode) {
        var button: UIButton
        var line: UIView
        switch tabBarMode {
        case .productLists:
            button = productListButton
            line = productListSelectLine
        case .reviews:
            button = reviewButton
            line = reviewSelectLine
        case .operationInfo:
            button = operationInfoButton
            line = operationInfoSelectLine
        }

        line.isHidden = false
        button.titleLabel?.font = UIFont.font(style: .titleMedium)
        button.setTitleColor(Asset.Colors.gray7.color, for: .normal)
    }

    private func addButtonTargets() {
        productListButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.mode = .productLists
            self.headerTapped?(self.mode)
        }, for: .touchUpInside)

        reviewButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.mode = .reviews
            self.headerTapped?(self.mode)
        }, for: .touchUpInside)

        operationInfoButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.mode = .operationInfo
            self.headerTapped?(self.mode)
        }, for: .touchUpInside)
    }

    private func layout() {
        [productListButton, reviewButton, divisionLine, productListSelectLine,
         reviewSelectLine, operationInfoButton, operationInfoSelectLine].forEach {
            contentView.addSubview($0)
        }

        productListButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(15)
        }

        reviewButton.snp.makeConstraints {
            $0.leading.equalTo(productListSelectLine.snp.trailing).offset(Constraint.tabSpacing)
            $0.top.equalToSuperview().inset(15)
        }

        operationInfoButton.snp.makeConstraints {
            $0.leading.equalTo(reviewButton.snp.trailing).offset(Constraint.tabSpacing)
            $0.top.equalToSuperview().inset(15)
        }

        [productListButton, reviewButton, operationInfoButton].forEach {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(reviewButton.snp.bottom).offset(7)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constraint.divisionLineHeight)
        }

        divisionLine.layer.zPosition = Constraint.divisionLineZPosition

        productListSelectLine.snp.makeConstraints {
            $0.leading.equalTo(productListButton)
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

extension StoreDetailTabBarCell {
    enum Constraint {
        static let headerViewLeadingInset: CGFloat = 25
        static let tabSpacing: CGFloat = 15
        static let divisionLineZPosition: CGFloat = 0
        static let selectLineZPosition: CGFloat = 1
        static let selectLineHeight: CGFloat = 2
        static let divisionLineHeight: CGFloat = 1
        static let selectLineMultiplier: CGFloat = 1
    }
}
