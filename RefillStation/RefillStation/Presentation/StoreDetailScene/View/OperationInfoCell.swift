//
//  OperationInfoView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class OperationInfoCell: UICollectionViewCell {

    static let reuseIdentifier = "operationInfoCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.font(style: .bodySmall)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        return button
    }()

    var reloadCell: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        addSeeMoreButtonAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(operation: OperationInfo, shouldShowSeeMore: Bool = false) {
        imageView.image = operation.image
        contentLabel.text = operation.content
        seeMoreButton.isHidden = !shouldShowSeeMore
    }

    func setUpSeeMore(shouldSeeMore: Bool) {
        if shouldSeeMore {
            contentLabel.numberOfLines = 0
            seeMoreButton.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
        } else {
            contentLabel.numberOfLines = 1
            seeMoreButton.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        }
    }

    private func layout() {
        [imageView, contentLabel, divisionLine, seeMoreButton].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(15)
        }

        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.top.equalTo(imageView.snp.top)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        seeMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(contentLabel.snp.bottom)
        }
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        seeMoreButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private func addSeeMoreButtonAction() {
        seeMoreButton.addAction(UIAction { [weak self] _ in
            self?.reloadCell?()
        }, for: .touchUpInside)
    }

}

struct OperationInfo {
    let image: UIImage
    let content: String
}
