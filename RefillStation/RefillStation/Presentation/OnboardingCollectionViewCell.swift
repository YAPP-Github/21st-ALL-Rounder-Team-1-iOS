//
//  OnboardingCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/16.
//

import UIKit
import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: OnboardingCollectionViewCell.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(style: .titleLarge1)
        label.textAlignment = .center
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(title: String, image: UIImage?) {
        titleLabel.text = title
        imageView.image = image
    }

    private func layout() {
        [titleLabel, imageView].forEach { contentView.addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

