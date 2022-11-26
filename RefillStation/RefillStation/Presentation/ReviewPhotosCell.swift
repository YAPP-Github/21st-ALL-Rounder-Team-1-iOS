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
        return button
    }()

    private let photoImageViews = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addPhotos() {
        photoImageViews.forEach { photo in
            orthogonalStackView.addArrangedSubview(photo)
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
