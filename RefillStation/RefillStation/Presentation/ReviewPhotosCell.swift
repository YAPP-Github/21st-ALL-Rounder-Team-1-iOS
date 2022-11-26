//
//  ReviewPhotosCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class ReviewPhotosCell: UICollectionViewCell {

    private let outerScrollView = UIScrollView()

    private let orthogonalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private let addPhotoButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let photoImageViews = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubview(outerScrollView)
        outerScrollView.addSubview(orthogonalStackView)

        outerScrollView.snp.makeConstraints { scrollView in
            scrollView.edges.equalTo(contentView)
        }

        orthogonalStackView.snp.makeConstraints { stackView in
            stackView.edges.equalTo(outerScrollView)
        }

        orthogonalStackView.addArrangedSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { addPhotoButton in
            addPhotoButton.width.equalTo(100)
        }
    }
}
