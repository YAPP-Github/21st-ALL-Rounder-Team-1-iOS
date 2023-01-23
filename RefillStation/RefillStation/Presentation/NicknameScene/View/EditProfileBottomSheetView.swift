//
//  ProfileBottomSheetViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/23.
//

import UIKit
import SnapKit

final class EditProfileBottomSheetView: UIView {
    var albumButtonTapped: (() -> Void)?
    var deleteButtonTapped: (() -> Void)?

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
        button.addTarget(self, action: #selector(albumButtonDidTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(DeleteButtonDidTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }

    private func layout() {
        [albumButton, deleteButton].forEach { addSubview($0) }
        albumButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(albumButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-14)
        }
    }

    @objc private func albumButtonDidTapped() {
        albumButtonTapped?()
    }

    @objc private func DeleteButtonDidTapped() {
        deleteButtonTapped?()
    }
}
