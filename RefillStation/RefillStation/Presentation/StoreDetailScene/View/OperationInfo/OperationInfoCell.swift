//
//  OperationInfoView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class OperationInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: OperationInfoCell.self)

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Asset.Colors.primary8.color
        return imageView
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.font(style: .bodySmall)
        label.textColor = Asset.Colors.gray6.color
        label.lineBreakMode = .byWordWrapping
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
        button.isHidden = true
        return button
    }()

    var seeMoreTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        addSeeMoreButtonAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(operation: OperationInfo, shouldShowMore: Bool = false) {
        imageView.image = operation.image
        contentLabel.setText(text: operation.content, font: .bodySmall)

        guard let isNewLineIncluded = contentLabel.text?.contains("\n") else { return }

        seeMoreButton.isHidden = !isNewLineIncluded

        if shouldShowMore {
            contentLabel.numberOfLines = 0
            seeMoreButton.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
            makeFirstLineBold(operation: operation)
        } else {
            contentLabel.numberOfLines = 1
            seeMoreButton.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        }
    }

    private func makeFirstLineBold(operation: OperationInfo) {
        if let targetString = operation.content.split(separator: "\n").map({ String($0) }).first {
            contentLabel.makeBold(targetString: targetString)
        }
    }

    private func layout() {
        [imageView, contentLabel, divisionLine, seeMoreButton].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15).priority(.low)
        }

        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.top.equalTo(imageView.snp.top)
            $0.trailing.equalToSuperview().inset(16)
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
            guard let self = self else { return }
            self.seeMoreTapped?()
        }, for: .touchUpInside)
    }
}

struct OperationInfo: Hashable {
    let image: UIImage?
    let content: String
}

fileprivate extension UILabel {
    func makeBold(targetString: String) {
        let font = UIFont.boldSystemFont(ofSize: self.font.pointSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}
