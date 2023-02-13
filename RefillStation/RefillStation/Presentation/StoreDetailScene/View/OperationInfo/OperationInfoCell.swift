//
//  OperationInfoView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class OperationInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: OperationInfoCell.self)

    private let contentLabelDefaultHeight: CGFloat = 20
    private let contentLabelInsetSum: CGFloat = 52

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Asset.Colors.primary8.color
        return imageView
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.font(style: .bodySmallOverTwoLine)
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
        button.isHidden = false
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

    override func prepareForReuse() {
        seeMoreButton.isHidden = true
    }

    func setUpContents(operation: OperationInfo, shouldShowMore: Bool = false, screenWidth: CGFloat = 0) {
        imageView.image = operation.image
        contentLabel.setText(text: operation.content, font: .bodySmallOverTwoLine)
        seeMoreButton.isHidden = !(contentLabel.isTruncated && !operation.content.isEmpty)
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.lineBreakStrategy = .hangulWordPriority

        if shouldShowMore {
            contentLabel.numberOfLines = 0
            seeMoreButton.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
        } else {
            contentLabel.numberOfLines = 1
            seeMoreButton.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        }

        let width = screenWidth == 0 ? contentView.frame.width : screenWidth
        let newSize = contentLabel.sizeThatFits(CGSize(width: width - contentLabelInsetSum,
                                         height: CGFloat.greatestFiniteMagnitude))
        let newHeight = newSize.height == 0 ? 20 : newSize.height
        contentLabel.snp.remakeConstraints {
            $0.height.equalTo(newHeight).priority(.required)
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
        }

        contentStackView.addArrangedSubview(contentLabel)

//        contentLabel.snp.remakeConstraints {
//            $0.height.equalTo(contentLabelDefaultHeight)
//        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        seeMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(15)
            $0.height.width.equalTo(16)
        }
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
