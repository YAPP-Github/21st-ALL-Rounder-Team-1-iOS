//
//  WriteReviewButtonCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/25.
//

import UIKit

final class MoveToWriteReviewCell: UICollectionViewCell {

    static let reuseIdentifier  = "writeReviewButtonCell"

    var moveToWriteReview: (() -> Void)?

    private let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.primary1.color
        return view
    }()

    private let didVisitedLabel: UILabel = {
        let label = UILabel()
        label.text = "매장에 방문한 적이 있다면?"
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodySmall)
        return label
    }()

    private let moveToWritingReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 쓰기", for: .normal)
        button.titleLabel?.font = UIFont.font(style: .buttonMedium)
        button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        button.setImage(Asset.Images.iconEdit.image, for: .normal)
        button.tintColor = Asset.Colors.gray6.color
        button.semanticContentAttribute = .forceRightToLeft
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        layout()
        addMoveToWriteReviewButtonTarget()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpContentView() {
        contentView.layer.cornerRadius = 6
    }

    private func layout() {
        contentView.addSubview(backgroundColorView)

        [didVisitedLabel, moveToWritingReviewButton].forEach {
            backgroundColorView.addSubview($0)
        }

        backgroundColorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        didVisitedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.bottom.equalToSuperview().inset(8)
        }

        moveToWritingReviewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(8)
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
        moveToWriteReview?()
    }
}
