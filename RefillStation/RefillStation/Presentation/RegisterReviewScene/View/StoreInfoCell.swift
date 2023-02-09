//
//  StoreInfoCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class StoreInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: StoreInfoCell.self)

    private let storeNamelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleSmall)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let storeLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodySmall)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(storeName: String, storeLocationInfo: String) {
        storeNamelabel.setText(text: storeName, font: .titleSmall)
        storeLocationLabel.setText(text: storeLocationInfo, font: .bodySmall)
    }

    private func layout() {
        [storeNamelabel, storeLocationLabel, dividerView].forEach {
            contentView.addSubview($0)
        }

        storeNamelabel.snp.makeConstraints { label in
            label.top.equalToSuperview()
            label.leading.trailing.equalToSuperview().inset(16)
        }

        storeLocationLabel.snp.makeConstraints { label in
            label.top.equalTo(storeNamelabel.snp.bottom).offset(5)
            label.leading.trailing.equalTo(storeNamelabel)
        }

        dividerView.snp.makeConstraints { view in
            view.top.equalTo(storeLocationLabel.snp.bottom).offset(16)
            view.leading.trailing.bottom.equalToSuperview()
            view.height.equalTo(1)
        }
    }
}
