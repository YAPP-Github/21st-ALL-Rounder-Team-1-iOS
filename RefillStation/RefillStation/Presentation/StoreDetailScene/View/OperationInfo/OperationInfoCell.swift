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
        label.numberOfLines = 0
        label.font = UIFont.font(style: .bodySmall) // TODO: body small 2줄이상 폰트 추가 및 교체
        label.textColor = Asset.Colors.gray6.color
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(contentLabel)
        return stackView
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

        guard contentLabel.isTruncated, !operation.content.isEmpty,
        let isNewLineIncluded = contentLabel.text?.contains("\n") else { return }

        if isNewLineIncluded || contentLabel.isTruncated {
            seeMoreButton.isHidden = false
        }

        if shouldShowMore {
            contentLabel.numberOfLines = 0
            seeMoreButton.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
            if let attrText = contentLabel.attributedText {
                let height = attrText.height(withConstrainedWidth: contentView.frame.width - 52)
                contentLabel.snp.remakeConstraints {
                    $0.height.greaterThanOrEqualTo(height)
                }
            }
        } else {
            contentLabel.numberOfLines = 1
            seeMoreButton.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
            contentLabel.lineBreakMode = .byTruncatingTail
        }
    }

    private func makeFirstLineBold(operation: OperationInfo) {
        if let targetString = operation.content.split(separator: "\n").map({ String($0) }).first {
            contentLabel.makeBold(targetString: targetString)
        }
    }

    private func layout() {
        [imageView, contentStackView, divisionLine, seeMoreButton].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalTo(seeMoreButton.snp.leading).offset(-8)
            $0.height.greaterThanOrEqualTo(20)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        seeMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(15)
        }

        imageView.setContentHuggingPriority(.required, for: .horizontal)
        contentLabel.setContentHuggingPriority(.required, for: .vertical)
        seeMoreButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        seeMoreButton.setContentHuggingPriority(.required, for: .horizontal)
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

    var isTruncated: Bool {
        guard let labelText = text, let font = font else { return false }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}

