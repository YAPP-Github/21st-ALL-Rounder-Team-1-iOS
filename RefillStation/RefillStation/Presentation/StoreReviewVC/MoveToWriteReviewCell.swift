//
//  WriteReviewButtonCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class MoveToWriteReviewCell: UICollectionViewCell {

    static let reuseIdentifier  = "writeReviewButtonCell"

    weak var delegate: MoveToWriteReviewCellDelegate?

    private let moveToWritingReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 남기기 ✎", for: .normal)
        button.titleLabel?.font = UIFont.font(style: .buttonLarge)
        button.setTitleColor(Asset.Colors.primary3.color, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        layout()
        addMoveToWriteReviewButtonTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.primary3.color.cgColor
        contentView.layer.cornerRadius = 6
    }

    private func layout() {
        contentView.addSubview(moveToWritingReviewButton)
        moveToWritingReviewButton.snp.makeConstraints { button in
            button.edges.equalToSuperview()
        }
    }

    private func addMoveToWriteReviewButtonTarget() {
        moveToWritingReviewButton.addTarget(
            self,
            action: #selector(moveToWriteReviewButtonTapped(_:)),
            for: .touchUpInside)
    }

    @objc
    private func moveToWriteReviewButtonTapped(_ sender: UIButton) {
        delegate?.moveToWriteReviewButtonTapped()
    }
}
