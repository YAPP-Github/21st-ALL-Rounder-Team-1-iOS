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
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [productListButton, reviewButton].forEach {
            addSubview($0)
        }

        productListButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }

        reviewButton.snp.makeConstraints {
            $0.leading.equalTo(productListButton.snp.trailing).offset(5)
            $0.top.bottom.equalToSuperview()
        }
        
    }
}
