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

    private let tagCollectionView = VotedTagCollectionView()

    init() {
        super.init(frame: .zero)
        layout()
        setLabelContents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {

    }

    private func setLabelContents() {

    }
}
