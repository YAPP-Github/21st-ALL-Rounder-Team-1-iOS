//
//  RequestRegionViewController.swift
//  RefillStation
//
//  Created by kong on 2022/12/03.
//

import UIKit
import SnapKit

final class RequestRegionViewController: UIViewController {

    // MARK: - Properties
    private let placeHolder = "서비스 신청을 원하는 지역을 자유롭게 적어주세요."
    private lazy var closeBarButtonItem = UIBarButtonItem(image: Asset.Images.iconClose.image,
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(cancelButtonDidTapped))

    // MARK: - UIComponents
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "어느 지역을 신청할까요?", font: .titleLarge2)
        return label
    }()
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "ex) ‘서울 강서구 염창동’", font: .bodySmall)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()
    private let descriptionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.iconBell.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "신청하신 지역에 서비스가 오픈되면\n알림을 드려요!", font: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        label.numberOfLines = 0
        return label
    }()
    private let requestButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("신청하기", for: .normal)
        return button
    }()
    private let regionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.textColor = .lightGray
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        textView.font = UIFont.font(style: .bodyMedium)
        textView.clipsToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = Asset.Colors.gray2.color.cgColor
        return textView
    }()
    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "0", font: .captionLarge)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()
    private let maxTextLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "/500", font: .captionLarge)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        setUpRegionTextView()
        addTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigatonBar()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Default Setting Methods
    private func layout() {
        [titleLabel, exampleLabel, descriptionIcon, descriptionLabel,
         regionTextView, textCountLabel, maxTextLabel, requestButton].forEach { view.addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        exampleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(titleLabel)
        }
        regionTextView.snp.makeConstraints {
            $0.top.equalTo(exampleLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(218)
        }
        textCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(maxTextLabel.snp.leading)
            $0.centerY.equalTo(maxTextLabel)
        }
        maxTextLabel.snp.makeConstraints {
            $0.trailing.bottom.equalTo(regionTextView).inset(16)
        }
        descriptionIcon.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel).offset(3)
            $0.leading.equalToSuperview().offset(34)
            $0.width.height.equalTo(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(requestButton.snp.top).offset(-22)
            $0.leading.equalTo(descriptionIcon.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().inset(16)
        }
        requestButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setUpRegionTextView() {
        regionTextView.delegate = self
        regionTextView.text = placeHolder
    }
    private func setUpNavigatonBar() {
        self.title = "지역 신청하기"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = closeBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = Asset.Colors.gray7.color
    }

    @objc private func cancelButtonDidTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension
extension RequestRegionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = nil
            textView.textColor = Asset.Colors.gray7.color
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
            textView.textColor = Asset.Colors.gray4.color
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        textCountLabel.setText(text: "\(textView.text.count)", font: .captionLarge)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textViewText = textView.text,
              let rangeToChange = Range(range, in: textViewText) else { return false }
        let updatedText = textViewText.replacingCharacters(in: rangeToChange, with: text)
        return updatedText.count <= 500
    }
}

extension RequestRegionViewController {
    func addTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
