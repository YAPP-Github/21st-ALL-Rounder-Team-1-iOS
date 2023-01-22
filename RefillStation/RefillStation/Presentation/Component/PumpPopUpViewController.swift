//
//  PumpPopUpViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/22.
//

import UIKit

final class PumpPopUpViewController: UIViewController {

    var actionButtons = [CTAButton]()
    var titleFont: UIFont? {
        didSet { titleLabel.font = titleFont }
    }
    var descriptionFont: UIFont? {
        didSet { descriptionLabel.font = descriptionFont }
    }

    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        return textView
    }()

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
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
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
        titleLabel.text = title
        descriptionLabel.text = description
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }

    func addAction(title: String?, handler: (() -> Void)? = nil) {
        let ctaButton = CTAButton()
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
    func addTextView(configurationHandler: ((UITextView) -> Void)) {
        configurationHandler(textView)
        if let indexOfActionButtonStackView = contentVerticalStackView
            .arrangedSubviews.firstIndex(of: actionButtonStackView) {
            contentVerticalStackView.insertArrangedSubview(textView, at: indexOfActionButtonStackView)
        }
    }

    /// ImageView를 PopUp 내 StackView의 최상단에 삽입합니다.
    ///  configurationHandler에서 표시될 image를 지정하거나 imageView의 height을 포함한 여러 constraint들을 추가하거나 layer등에 변화를 줄 수 있습니다.
    func addImageView(configurationHandler: ((UIImageView) -> Void)) {
        configurationHandler(imageView)
        contentVerticalStackView.insertArrangedSubview(imageView, at: 0)
    }

    private func layout() {
        view.addSubview(outerView)
        outerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(36)
        }

        outerView.addSubview(contentVerticalStackView)
        contentVerticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
        [titleLabel, descriptionLabel].forEach {
            if $0.text != nil {
                contentVerticalStackView.addArrangedSubview($0)
            }
        }
        contentVerticalStackView.addArrangedSubview(actionButtonStackView)
    }
}
