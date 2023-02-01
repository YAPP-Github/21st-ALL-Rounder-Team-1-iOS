//
//  ReviewPhotosCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit
import PhotosUI

final class ReviewPhotosCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ReviewPhotosCell.self)
    weak var delegate: ReviewPhotoDelegate?
    private let outerScrollView = UIScrollView()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    private let pleaseReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰를 남겨주세요!"
        label.font = UIFont.font(style: .titleMedium)
        label.textColor = Asset.Colors.gray7.color
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
        button.setImage(Asset.Images.iconPhoto.image, for: .normal)
        button.layer.borderColor = Asset.Colors.gray3.color.cgColor
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 90).isActive = true
        button.tintColor = Asset.Colors.gray5.color
        return button
    }()

    private var photoImages = [UIImage]()

    private var defaultImageView: UIImageView {
        let imageView = UIImageView()
        imageView.layer.borderColor = Asset.Colors.gray3.color.cgColor
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        addPhotoButtonTarget()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addPhotos() {
        photoImages.forEach { image in
            let imageView = defaultImageView
            imageView.image = image
            orthogonalStackView.addArrangedSubview(imageView)
        }
    }

    private func layout() {
        [dividerView, pleaseReviewLabel, addPhotoButton, outerScrollView].forEach {
            contentView.addSubview($0)
        }

        dividerView.snp.makeConstraints { view in
            view.leading.trailing.top.equalToSuperview()
            view.height.equalTo(1)
        }

        pleaseReviewLabel.snp.makeConstraints { label in
            label.top.equalTo(dividerView.snp.bottom).offset(20)
            label.leading.trailing.equalTo(contentView)
        }

        addPhotoButton.snp.makeConstraints { button in
            button.top.equalTo(pleaseReviewLabel.snp.bottom).offset(10)
            button.leading.bottom.equalToSuperview()
        }

        outerScrollView.addSubview(orthogonalStackView)

        outerScrollView.snp.makeConstraints { scrollView in
            scrollView.top.equalTo(pleaseReviewLabel.snp.bottom).offset(10)
            scrollView.trailing.bottom.equalTo(contentView)
            scrollView.leading.equalTo(addPhotoButton.snp.trailing).offset(10)
        }

        orthogonalStackView.snp.makeConstraints { stackView in
            stackView.edges.equalTo(outerScrollView)
        }
    }

    private func addPhotoButtonTarget() {
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped(_:)), for: .touchUpInside)
    }

    @objc
    private func addPhotoButtonTapped(_ sender: UIButton) {
        delegate?.imageAddButtonTapped()
    }
}

extension ReviewPhotosCell: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let dispatchGroup = DispatchGroup()
        let items = results.map { $0.itemProvider }
        let lastIndex = items.count - 1

        if items.isEmpty {
            self.delegate?.dismiss(reviewPhotos: photoImages)
            return
        }

        removeAllPhotoImages()

        dispatchGroup.enter()
        for itemIndex in 0...lastIndex {
            if items[itemIndex].canLoadObject(ofClass: UIImage.self) == false {
                return
            }

            items[itemIndex].loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let image = image as? UIImage {
                    self?.photoImages.append(image)
                }
                if itemIndex == lastIndex {
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.addPhotos()
            self?.delegate?.dismiss(reviewPhotos: self?.photoImages ?? [])
        }
    }

    private func removeAllPhotoImages() {
        photoImages.removeAll()
        while orthogonalStackView.arrangedSubviews.isEmpty == false {
            if let last = orthogonalStackView.arrangedSubviews.last {
                orthogonalStackView.removeArrangedSubview(last)
            }
        }
    }
}
