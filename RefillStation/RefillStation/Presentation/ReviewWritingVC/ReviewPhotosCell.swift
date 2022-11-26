//
//  ReviewPhotosCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewPhotosCell: UICollectionViewCell {

    static let reuseIdentifier = "reviewPhotosCell"

    private let outerScrollView = UIScrollView()

    private let pleaseReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰를 남겨주세요!"
        return label
    }()

    private let orthogonalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        return button
    }()

    private let photoImageViews = [UIImage]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addPhotos() {
        photoImageViews.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.layer.cornerRadius = 5
            imageView.layer.borderWidth = 1
            orthogonalStackView.addArrangedSubview(imageView)
        }
    }

    private func layout() {
        [pleaseReviewLabel, outerScrollView].forEach {
            contentView.addSubview($0)
        }

        pleaseReviewLabel.snp.makeConstraints { label in
            label.leading.top.equalTo(contentView)
        }

        outerScrollView.addSubview(orthogonalStackView)

        outerScrollView.snp.makeConstraints { scrollView in
            scrollView.top.equalTo(pleaseReviewLabel.snp.bottom).offset(10)
            scrollView.leading.trailing.bottom.equalTo(contentView)
        }

        orthogonalStackView.snp.makeConstraints { stackView in
            stackView.edges.equalTo(outerScrollView)
        }

        orthogonalStackView.addArrangedSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { addPhotoButton in
            addPhotoButton.width.height.equalTo(100)
        }
    }
}
