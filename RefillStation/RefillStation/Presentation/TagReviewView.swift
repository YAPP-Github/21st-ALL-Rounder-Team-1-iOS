//
//  TagReviewView.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/23.
//

import UIKit
import SnapKit

final class TagReviewView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let totalVotePeopleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let tagCollectionView: VotedTagCollectionView

    init(tagCollectionView: VotedTagCollectionView) {
        self.tagCollectionView = tagCollectionView
        super.init(frame: .zero)
        addConstraints()
        setLabelContents()
    }

    required init?(coder: NSCoder) {
        self.tagCollectionView = VotedTagCollectionView(tagReviews: [])
        super.init(coder: coder)
    }

    private func addConstraints() {

    }

    private func setLabelContents() {

    }
}
