//
//  StoreInfoViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class StoreDetailInfoViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: StoreDetailInfoViewCell.self)

    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.gray2.color
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let storeInfoOuterView: UIView = {
        let outerView = UIView()
        outerView.backgroundColor = .white
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 10
        outerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return outerView
    }()
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleLarge1)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let storeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()
    private lazy var checkVisitGuideButton: UIButton = {
        let button = UIButton()
        button.setTitle("매장 방문 가이드 읽어보기", for: .normal)
        button.setImage(Asset.Images.iconArrowRightSmall.image.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 3, left: 0, bottom: 3, right: 0)
        button.titleLabel?.font = .font(style: .bodyMedium)
        button.setTitleColor(Asset.Colors.gray5.color, for: .normal)
        button.tintColor = Asset.Colors.gray5.color
        button.semanticContentAttribute = .forceRightToLeft
        button.addAction(UIAction { [weak self] _ in
            self?.checkVisitGuideButtonTapped?()
        }, for: .touchUpInside)
        return button
    }()
    private let storeStackOuterView: UIView = { // StackView에는 cornerRadius적용이 불가하기 때문에 감싸는 View를 제작
        let outerView = UIView()
        outerView.layer.borderColor = Asset.Colors.gray1.color.cgColor
        outerView.layer.borderWidth = 1
        outerView.layer.cornerRadius = 4
        outerView.clipsToBounds = true
        return outerView
    }()
    private let storeInfoStackView: StoreDetailInfoStackView = {
        let stackView = StoreDetailInfoStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = Asset.Colors.gray1.color
        stackView.spacing = 1
        return stackView
    }()
    private let bottomDivisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    var storeButtonTapped: ((StoreDetailViewModel.StoreInfoButtonType) -> Void)?
    var checkVisitGuideButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        layout()
        addButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(store: Store) {
        storeNameLabel.setText(text: store.name, font: .titleLarge1)
        storeAddressLabel.setText(text: store.address, font: .bodyMedium)
        setUpLikeCount(response: .init(recommendCount: store.recommendedCount,
                                       didRecommended: store.didUserRecommended))
        if let storeImageURL = URL(string: store.imageURL.first ?? "") {
            storeImageView.kf.setImage(with: storeImageURL)
        } else {
            storeImageView.image = Asset.Images.storeDefualtImage.image
        }
    }

    func setUpLikeCount(response: RecommendStoreResponseValue) {
        let recommendState: RecommendButtonState = response.didRecommended ? .didRecommended : .didNotRecommended
        let title = response.recommendCount == 0 ? "추천" : "\(response.recommendCount)"

        storeInfoStackView.recommendedButton.tintColor = recommendState.color
        storeInfoStackView.recommendedButton.setTitleColor(recommendState.color, for: .normal)
        storeInfoStackView.recommendedButton.setImage(recommendState.image, for: .normal)
        storeInfoStackView.recommendedButton.setTitle(title, for: .normal)
    }

    private func addButtonActions() {
        [storeInfoStackView.callButton,
         storeInfoStackView.storeLinkButton,
         storeInfoStackView.recommendedButton].forEach { storeButton in
            storeButton.addAction(UIAction { _ in
                self.storeButtonTapped?(storeButton.type)
            }, for: .touchUpInside)
        }
    }

    private func layout() {
        [storeImageView, storeInfoOuterView].forEach { addSubview($0) }
        [storeNameLabel, checkVisitGuideButton, storeAddressLabel,
         storeStackOuterView, bottomDivisionLine].forEach {
            storeInfoOuterView.addSubview($0)
        }
        storeStackOuterView.addSubview(storeInfoStackView)

        storeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }

        storeInfoOuterView.snp.makeConstraints {
            $0.top.equalTo(storeImageView.snp.bottom).offset(-10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        storeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        checkVisitGuideButton.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(16)
        }
        storeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(checkVisitGuideButton.snp.bottom).offset(4)
            $0.leading.equalTo(storeNameLabel)
        }
        storeStackOuterView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.top.equalTo(storeAddressLabel.snp.bottom).offset(20)
        }
        storeInfoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(12)
        }
        bottomDivisionLine.snp.makeConstraints {
            $0.top.equalTo(storeStackOuterView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(8)
        }
    }
}

extension StoreDetailInfoViewCell {
    enum RecommendButtonState {
        case didRecommended
        case didNotRecommended

        var color: UIColor {
            switch self {
            case .didRecommended:
                return Asset.Colors.primary10.color
            case .didNotRecommended:
                return Asset.Colors.gray5.color
            }
        }

        var image: UIImage? {
            switch self {
            case .didRecommended:
                return Asset.Images.iconThumbsupFill.image
            case .didNotRecommended:
                return Asset.Images.iconThumbsup.image
            }
        }
    }
}
