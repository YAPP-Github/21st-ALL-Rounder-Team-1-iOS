//
//  RegisterReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit
import PhotosUI

final class RegisterReviewViewController: UIViewController {

    var coordinator: RegisterReviewCoordinator?
    private let viewModel: DefaultTagReviewViewModel
    private lazy var outerCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: compositionalLayout())
    private let collectionViewBottomInset: CGFloat = 80

    private let phPickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 3
        let phPickerVC = PHPickerViewController(configuration: configuration)
        return phPickerVC
    }()

    private lazy var registerButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("등록하기", for: .normal)
        button.isEnabled = false
        button.addAction(UIAction { _ in
            self.viewModel.registerButtonTapped()
            button.isEnabled = false
        }, for: .touchUpInside)
        return button
    }()

    init(viewModel: DefaultTagReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "리뷰 쓰기"
        view.backgroundColor = .white
        bind()
        setUpCollectionView()
        layout()
        addKeyboardNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        tabBarController?.tabBar.isHidden = false
    }

    private func bind() {
        viewModel.reviewCountFetchCompleted = {
            self.coordinator?.registerReviewSuccessed(userLevel: self.viewModel.levelUppedLevel)
        }
    }

    private func setUpCollectionView() {
        outerCollectionView.backgroundColor = .white
        outerCollectionView.register(StoreInfoCell.self,
                                     forCellWithReuseIdentifier: StoreInfoCell.reuseIdentifier)
        outerCollectionView.register(VoteTitleCell.self,
                                     forCellWithReuseIdentifier: VoteTitleCell.reuseIdentifier)
        outerCollectionView.register(TagReviewCell.self,
                                     forCellWithReuseIdentifier: TagReviewCell.reuseIdentifier)
        outerCollectionView.register(ReviewPhotosCell.self,
                                forCellWithReuseIdentifier: ReviewPhotosCell.reuseIdentifier)
        outerCollectionView.register(ReviewDescriptionCell.self,
                                forCellWithReuseIdentifier: ReviewDescriptionCell.reuseIdentifier)
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
        outerCollectionView.allowsMultipleSelection = true
        outerCollectionView.keyboardDismissMode = .onDrag
        outerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: collectionViewBottomInset, right: 0)
    }

    private func layout() {
        [outerCollectionView, registerButton].forEach { view.addSubview($0) }
        outerCollectionView.snp.makeConstraints { collection in
            collection.edges.equalTo(view.safeAreaLayoutGuide)
        }
        registerButton.snp.makeConstraints { button in
            button.bottom.equalTo(view.safeAreaLayoutGuide)
            button.leading.trailing.equalToSuperview().inset(16)
            button.height.equalTo(50)
        }
    }

    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func noKeywordTagDidTapped(isSelected: Bool,
                                       collectionView: UICollectionView,
                                       indexPath: IndexPath) {
        viewModel.tags.filter { $0 != .noKeywordToChoose }
            .forEach { tag in
                let indexPathForDeselectItem = IndexPath(row: tag.id - 1, section: indexPath.section)
                guard let cell = collectionView.cellForItem(at: indexPathForDeselectItem)
                        as? TagReviewCell else { return }
                if isSelected {
                    collectionView.deselectItem(at: indexPathForDeselectItem, animated: false)
                    cell.setUpDisabledButton()
                } else {
                    cell.setUpUnselectedButton()
                }
            }
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
           let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        outerCollectionView.contentInset = .init(top: 0, left: 0,
                                                 bottom: keyboardRect.height + collectionViewBottomInset, right: 0)
        outerCollectionView.scrollToItem(at: IndexPath(item: 0, section: Section.reviewDescription.rawValue),
                                         at: .top, animated: true)
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: -keyboardRect.height)
        })
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        outerCollectionView.contentInset = .init(top: 0, left: 0, bottom: collectionViewBottomInset, right: 0)
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}

// MARK: - UICollectionViewDataSource

extension RegisterReviewViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.tagReview.rawValue:
            return viewModel.tags.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.storeInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoreInfoCell.reuseIdentifier,
                for: indexPath) as? StoreInfoCell else { return UICollectionViewCell() }
            cell.setUpContents(storeName: viewModel.storeName, storeLocationInfo: viewModel.storeLocationInfo)
            return cell
        case Section.voteTitle.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: VoteTitleCell.reuseIdentifier,
                for: indexPath) as? VoteTitleCell else { return UICollectionViewCell() }
            return cell
        case Section.tagReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TagReviewCell.reuseIdentifier,
                for: indexPath) as? TagReviewCell else { return UICollectionViewCell() }
            cell.setUpContents(image: viewModel.tags[indexPath.row].image,
                               title: viewModel.tags[indexPath.row].text)
            if let items = collectionView.indexPathsForSelectedItems, items.contains(indexPath) {
                cell.isSelected = true
            } else {
                viewModel.noKeywordTagDidSelected ? cell.setUpDisabledButton() : cell.setUpUnselectedButton()
            }
            return cell
        case Section.photoReview.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewPhotosCell.reuseIdentifier,
                for: indexPath) as? ReviewPhotosCell else { return UICollectionViewCell() }
            cell.delegate = self
            phPickerViewController.delegate = cell
            return cell
        case Section.reviewDescription.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewDescriptionCell.reuseIdentifier,
                for: indexPath) as? ReviewDescriptionCell else { return UICollectionViewCell() }
            cell.didChangeText = { text in
                self.viewModel.reviewContents = text
                self.registerButton.isEnabled = self.viewModel.setUpRegisterButtonState()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewCompositionalLayout
extension RegisterReviewViewController {
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            return Section(rawValue: section)?.layoutSection
        }, configuration: configuration)
    }
}

extension RegisterReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return viewModel.shouldSelectCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
        registerButton.isEnabled = viewModel.setUpRegisterButtonState()
        if viewModel.noKeywordTagDidSelected {
            noKeywordTagDidTapped(isSelected: true,
                                  collectionView: collectionView,
                                  indexPath: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if viewModel.noKeywordTagDidSelected {
            noKeywordTagDidTapped(isSelected: false,
                                  collectionView: collectionView,
                                  indexPath: indexPath)
        }
        viewModel.didDeselectItemAt(indexPath: indexPath)
        registerButton.isEnabled = viewModel.setUpRegisterButtonState()
    }
}

// MARK: - ReviewPhotoDelegate
extension RegisterReviewViewController: ReviewPhotoDelegate {
    func imageAddButtonTapped() {
        present(phPickerViewController, animated: true)
    }

    func dismiss(reviewPhotos: [UIImage]) {
        viewModel.reviewPhotos = reviewPhotos
        registerButton.isEnabled = viewModel.setUpRegisterButtonState()
        dismiss(animated: true)
    }
}
