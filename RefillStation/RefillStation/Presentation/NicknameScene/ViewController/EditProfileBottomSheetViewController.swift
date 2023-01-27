//
//  EditProfilePopUpViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/24.
//

import UIKit
import SnapKit
import PhotosUI

final class EditProfileBottomSheetViewController: UIViewController {

    var didFinishPhotoPicker: ((UIImage?) -> Void)?
    var deleteProfileImage: (() -> Void)?

    private let phPickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let phPickerVC = PHPickerViewController(configuration: configuration)
        return phPickerVC
    }()

    private let bottomSheetView: UIView = {
        let bottomSheetView = UIView()
        bottomSheetView.backgroundColor = .white
        bottomSheetView.layer.cornerRadius = 10
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bottomSheetView
    }()

    private lazy var albumButton: UIButton = {
        let button = UIButton()
        button.setTitle("앨범에서 선택", for: .normal)
        button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.setImage(Asset.Images.iconAlbum.image.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.tintColor = Asset.Colors.gray6.color
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.addAction(UIAction { _ in
            self.present(self.phPickerViewController, animated: true)
        }, for: .touchUpInside)
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 사진 삭제", for: .normal)
        button.setTitleColor(Asset.Colors.error.color, for: .normal)
        button.titleLabel?.font = .font(style: .buttonLarge)
        button.setImage(Asset.Images.iconTrashcan.image.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.tintColor = Asset.Colors.error.color
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.addAction(UIAction { _ in
            self.deleteProfileImage?()
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        phPickerViewController.delegate = self
        layout()
        addTapGesture()
    }

    private func layout() {
        view.addSubview(bottomSheetView)
        [albumButton, deleteButton].forEach { bottomSheetView.addSubview($0) }
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(164)
        }
        albumButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(albumButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14)
        }
    }

    private func addTapGesture() {
        view.addGestureRecognizer((UITapGestureRecognizer(target: self,
                                                          action: #selector(dismissBottomSheet))))
    }

    @objc private func dismissBottomSheet() {
        self.dismiss(animated: true)
    }
}

extension EditProfileBottomSheetViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let item = results.first?.itemProvider
        if let item = item, item.canLoadObject(ofClass: UIImage.self) {
            item.loadObject(ofClass: UIImage.self) { [weak self] (image, _) in
                DispatchQueue.main.async {
                    self?.didFinishPhotoPicker?(image as? UIImage)
                    self?.dismiss(animated: true)
                }
            }
        }
    }
}
