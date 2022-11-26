//
//  StoreInfoCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class StoreInfoCell: UICollectionViewCell {

    static let reuseIdentifier = "storeInfoCell"

    private let storeNamelabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let storeLocationLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpContents(storeName: String, storeLocationInfo: String) {
        storeNamelabel.text = storeName
        storeLocationLabel.text = storeLocationInfo
    }

    private func layout() {
        [storeNamelabel, storeLocationLabel].forEach {
            contentView.addSubview($0)
        }

        storeNamelabel.snp.makeConstraints { label in
            label.top.leading.trailing.equalToSuperview().inset(5)
        }

        storeLocationLabel.snp.makeConstraints { label in
            label.top.equalTo(storeNamelabel.snp.bottom).offset(5)
            label.leading.trailing.bottom.equalToSuperview()
        }
    }
}
