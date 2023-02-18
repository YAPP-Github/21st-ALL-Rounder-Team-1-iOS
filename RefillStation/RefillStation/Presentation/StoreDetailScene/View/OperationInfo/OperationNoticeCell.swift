//
//  OperationNoticeCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/28.
//

import UIKit

final class OperationNoticeCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: OperationNoticeCell.self)

    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "매장 상황에 따라 운영시간이 달라질 수 있어요.", font: .bodySmall)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    private lazy var noticeView: UIView = {
        let noticeView = UIView()
        noticeView.backgroundColor = Asset.Colors.gray1.color
        noticeView.layer.cornerRadius = 4
        noticeView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        return noticeView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(noticeView)
        noticeView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
