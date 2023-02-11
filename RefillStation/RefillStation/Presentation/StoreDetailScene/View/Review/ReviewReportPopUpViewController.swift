//
//  ReviewReportPopUpViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/23.
//

import UIKit

final class ReviewReportPopUpViewController: PumpPopUpViewController {

    var coordinator: StoreDetailCoordinator?
    private let placeholder = "신고할 사항을 입력해주세요"
    private let viewModel: ReviewReportPopUpViewModel
    private let dismissCompletion: (() -> Void)

    init(viewModel: ReviewReportPopUpViewModel, dismissCompletion: @escaping (() -> Void)) {
        self.viewModel = viewModel
        self.dismissCompletion = dismissCompletion
        super.init(title: "어떤 이유로 신고하시나요?", description: nil)
        addTextView()
        addActions()
        actionButtons[1].isEnabled = false
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

    private func addActions() {
        addAction(title: "취소", style: .cancel) {
            self.dismiss(animated: true)
        }
        addAction(title: "신고하기", style: .basic) {
            self.viewModel.reportButtonTapped {
                self.dismiss(animated: true) {
                    self.dismissCompletion()
                }
            }
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

    func textViewDidChange(_ textView: UITextView) {
        actionButtons[1].isEnabled = !textView.text.isEmpty
    }
}
