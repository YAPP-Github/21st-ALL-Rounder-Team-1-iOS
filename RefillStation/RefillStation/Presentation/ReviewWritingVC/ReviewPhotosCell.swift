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

    static let reuseIdentifier = "reviewPhotosCell"
    weak var delegate: ReviewPhotoDelegate?
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
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()

    private var photoImages = [UIImage]()

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
            let imageView = UIImageView(image: image)
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.layer.cornerRadius = 5
            imageView.layer.borderWidth = 1
            imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            imageView.clipsToBounds = true
            orthogonalStackView.addArrangedSubview(imageView)
        }
    }

    private func layout() {
        [pleaseReviewLabel, addPhotoButton, outerScrollView].forEach {
            contentView.addSubview($0)
        }

        pleaseReviewLabel.snp.makeConstraints { label in
            label.leading.top.equalTo(contentView)
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
            self.delegate?.dismiss()
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
            self?.delegate?.dismiss()
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
