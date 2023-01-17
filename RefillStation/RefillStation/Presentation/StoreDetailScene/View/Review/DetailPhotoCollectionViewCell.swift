//
//  DetailPhotoCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/17.
//

import UIKit

final class DetailPhotoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: DetailPhotoCollectionViewCell.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
