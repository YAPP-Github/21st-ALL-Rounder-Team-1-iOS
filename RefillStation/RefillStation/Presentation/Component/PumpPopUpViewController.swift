//
//  PumpPopUpViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/22.
//

import UIKit

class PumpPopUpViewController: UIViewController {

    var actionButtons = [CTAButton]()

    var titleConfigurationHandler: ((UILabel) -> Void)? {
        didSet { titleConfigurationHandler?(titleLabel) }
    }

    var descriptionConfigurationHandler: ((UILabel) -> Void)? {
        didSet { descriptionConfigurationHandler?(descriptionLabel) }
    }

    private let outerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()

    private let contentVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .font(style: .titleMedium)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .font(style: .bodyMedium)
        label.numberOfLines = 0
        return label
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.tintColor = Asset.Colors.primary10.color
        return textView
    }()

    private lazy var textViewWithBottomLine: UIView = {
        let textViewOuterView = UIView()
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray2.color
        [textView, line].forEach { textViewOuterView.addSubview($0) }
        textView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        line.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        return textViewOuterView
    }()

    private let actionButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()

    init(title: String?, description: String?) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        let title = title?.replacingOccurrences(of: "\\n", with: "\n")
        let description = description?.replacingOccurrences(of: "\\n", with: "\n")
        titleLabel.setText(text: title, font: .titleMediumOverTwoLine)
        descriptionLabel.setText(text: description, font: .bodyMediumOverTwoLine)
        [titleLabel, descriptionLabel].forEach { $0.textAlignment = .center }
        layout()
        addTapGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.6)
    }

    override func viewDidAppear(_ animated: Bool) {
        outerView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constraint.outerViewInset)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            self.view.layoutIfNeeded()
        }
    }

    func addAction(
        title: String?,
        style: CTAButton.Style,
        handler: (() -> Void)? = nil
    ) {
        let ctaButton = CTAButton(style: style)
        actionButtons.append(ctaButton)
        ctaButton.setTitle(title, for: .normal)
        actionButtonStackView.addArrangedSubview(ctaButton)
        ctaButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        ctaButton.addAction(UIAction { _ in
            handler?()
        }, for: .touchUpInside)
    }

    /// TextView를 PopUp 내 descriptionLabel 하단에 삽입합니다.
    ///  configurationHandler에서 textView의 height을 포함한 여러 constraint들을 추가하거나 layer등에 변화를 줄 수 있습니다.
    ///  UITextViewDelegate이 사용되어야 하는 경우에도 configurationHandler를 통해 지정해줄 수 있습니다.
    func addTextView(withBottomLine: Bool, configurationHandler: ((UITextView) -> Void)) {
        configurationHandler(textView)
        if let indexOfActionButtonStackView = contentVerticalStackView
            .arrangedSubviews.firstIndex(of: actionButtonStackView) {
            if withBottomLine {
                contentVerticalStackView.insertArrangedSubview(textViewWithBottomLine, at: indexOfActionButtonStackView)
            } else {
                contentVerticalStackView.insertArrangedSubview(textView, at: indexOfActionButtonStackView)
            }
        }
    }

    /// ImageView를 PopUp 내 StackView의 최상단에 삽입합니다.
    ///  configurationHandler에서 표시될 image를 지정하거나 imageView의 height을 포함한 여러 constraint들을 추가하거나 layer등에 변화를 줄 수 있습니다.
    func addImageView(configurationHandler: ((UIImageView) -> Void)) {
        imageView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        configurationHandler(imageView)
        contentVerticalStackView.insertArrangedSubview(imageView, at: 0)
    }

    private func layout() {
        view.addSubview(outerView)
        outerView.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constraint.outerViewInset)
        }

        outerView.addSubview(contentVerticalStackView)
        contentVerticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constraint.contentInset)
        }

        [titleLabel, descriptionLabel].forEach {
            let newSize = $0.sizeThatFits(CGSize(
                width: view.frame.width - 2 * (Constraint.contentInset + Constraint.outerViewInset),
                height: CGFloat.greatestFiniteMagnitude
            ))
            $0.snp.makeConstraints { label in
                label.height.equalTo(newSize.height)
            }
            if $0.text != nil {
                contentVerticalStackView.addArrangedSubview($0)
            }
        }
        if titleLabel.text != nil && descriptionLabel.text != nil {
            contentVerticalStackView.setCustomSpacing(12, after: titleLabel)
        }

        contentVerticalStackView.addArrangedSubview(actionButtonStackView)
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension PumpPopUpViewController {
    enum Constraint {
        static let outerViewInset: CGFloat = 36
        static let contentInset: CGFloat = 24
    }
}
