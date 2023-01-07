//
//  OperationInfoView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class OperationInfoCell: UICollectionViewCell {

    static let reuseIdentifier = "operationInfoCell"

    private let timeInfoView = InfoView()
    private let phoneNumberInfoView = InfoView()
    private let linkInfoView = InfoView()
    private let locationInfoView = InfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents() {
        timeInfoView.setUpContents(image: UIImage(systemName: "clock"), title: "일 11:00 - 18:00")
        phoneNumberInfoView.setUpContents(image: UIImage(systemName: "phone"), title: "02-331-4958")
        linkInfoView.setUpContents(image: UIImage(systemName: "link"), title: "www.zzasplaystore.com")
        locationInfoView.setUpContents(image: UIImage(systemName: "location"), title: "서울 성북구 동선동 4가\n효성해링턴 플레이스 106동 1303호")
        layoutIfNeeded()
    }

    private func layout() {
        [timeInfoView, phoneNumberInfoView, linkInfoView, locationInfoView].forEach {
            contentView.addSubview($0)
        }

        timeInfoView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }

        phoneNumberInfoView.snp.makeConstraints {
            $0.top.equalTo(timeInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        linkInfoView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        locationInfoView.snp.makeConstraints {
            $0.top.equalTo(linkInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

private class InfoView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.font(style: .bodySmall)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(image: UIImage?, title: String, shouldShowSeeMore: Bool = false) {
        imageView.image = image
        contentLabel.text = title
        seeMoreButton.isHidden = !shouldShowSeeMore
        layoutIfNeeded()
    }

    private func layout() {
        [imageView, contentLabel, divisionLine, seeMoreButton].forEach {
            addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }

        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.bottom.equalToSuperview().inset(15)
            $0.top.equalTo(imageView.snp.top)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        seeMoreButton.snp.makeConstraints {
            $0.leading.equalTo(contentLabel.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}
