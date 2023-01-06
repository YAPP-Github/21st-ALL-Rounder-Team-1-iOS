//
//  VotedTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class VotedTagCell: UICollectionViewCell {

    static let reuseIdentifier = "votedTagCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tagReviews: [TagReview]) {

    }
}

fileprivate final class FirstRankView: UIView {
    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let divisionLine: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
}

fileprivate final class OtherRankView: UIView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
