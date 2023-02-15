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
    var isReviewImageLoading = false

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    private let pleaseReviewLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "리뷰를 남겨주세요!", font: .titleMedium)
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
        DispatchQueue.main.async {
            self.photoImages.prefix(3).forEach { image in
                let imageView = self.defaultImageView
                imageView.image = image
                self.orthogonalStackView.addArrangedSubview(imageView)
            }
        }
    }

    private func layout() {
        [dividerView, pleaseReviewLabel, addPhotoButton, outerScrollView].forEach {
            contentView.addSubview($0)
        }

        dividerView.snp.makeConstraints { view in
            view.top.equalToSuperview().inset(15)
            view.leading.trailing.equalToSuperview()
            view.height.equalTo(1)
        }

        pleaseReviewLabel.snp.makeConstraints { label in
            label.top.equalTo(dividerView.snp.bottom).offset(20)
            label.leading.trailing.equalTo(contentView)
        }

        addPhotoButton.snp.makeConstraints { button in
            button.top.equalTo(pleaseReviewLabel.snp.bottom).offset(16)
            button.leading.bottom.equalToSuperview()
        }

        outerScrollView.addSubview(orthogonalStackView)

        outerScrollView.snp.makeConstraints { scrollView in
            scrollView.top.equalTo(pleaseReviewLabel.snp.bottom).offset(16)
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
        guard !isReviewImageLoading else { return }
        isReviewImageLoading = true
        let items = results.map { $0.itemProvider }
        removeAllPhotoImages()
        Task {
            for item in items {
                do {
                    photoImages.append(try await loadPhoto(item: item))
                } catch {
                    print(error)
                }
            }
            addPhotos()
            delegate?.dismiss(reviewPhotos: photoImages)
            isReviewImageLoading = false
        }
    }

    private func loadPhoto(item: NSItemProvider) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ continuation in
            if item.canLoadObject(ofClass: UIImage.self) == false {
                continuation.resume(throwing: PHPickerError.canNotLoadImage)
            }

            item.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage, error == nil else {
                    continuation.resume(throwing: PHPickerError.canNotLoadImage)
                    return
                }
                continuation.resume(returning: image)
            }
        })
    }

    private func removeAllPhotoImages() {
        photoImages.removeAll()
        orthogonalStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

extension ReviewPhotosCell {
    enum PHPickerError: Error {
        case canNotLoadImage
    }
}
