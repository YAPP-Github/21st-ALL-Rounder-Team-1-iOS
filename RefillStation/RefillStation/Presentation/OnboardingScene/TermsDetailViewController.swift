//
//  TermsDetailViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/29.
//

import UIKit
import SnapKit

final class TermsDetailViewController: UIViewController {
    private let termsType: TermsType
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.text = self.termsType.content
        textView.font = .font(style: .bodySmall)
        textView.textColor = Asset.Colors.gray5.color
        textView.showsVerticalScrollIndicator = false
        textView.isEditable = false
        return textView
    }()

    init(termsType: TermsType) {
        self.termsType = termsType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .black
        tabBarController?.tabBar.isHidden = false
    }

    private func layout() {
        view.addSubview(termsTextView)
        termsTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    private func setUpNavigationBar() {
        self.title = termsType.title
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = Asset.Colors.gray7.color
    }
}
