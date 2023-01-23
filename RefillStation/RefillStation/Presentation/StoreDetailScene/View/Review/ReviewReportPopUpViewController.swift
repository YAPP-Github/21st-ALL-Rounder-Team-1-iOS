//
//  ReviewReportPopUpViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/23.
//

import UIKit

final class ReviewReportPopUpViewController: PumpPopUpViewController {

    private let placeholder = "신고할 사항을 입력해주세요"

    override init(title: String?, description: String?) {
        super.init(title: title, description: description)
        addTextView()
        addAction()
        addCloseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func addTextView() {
        addTextView(withBottomLine: true) { textView in
            textView.delegate = self
            textView.text = placeholder
            textView.textColor = Asset.Colors.gray4.color
            textView.snp.makeConstraints {
                $0.height.equalTo(40)
            }
            textView.font = .font(style: .bodyLarge)
        }
    }

    private func addAction() {
        addAction(title: "신고하기") {
            self.dismiss(animated: true)
        }
    }
}

extension ReviewReportPopUpViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = Asset.Colors.gray7.color
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = Asset.Colors.gray4.color
        }
    }
}
