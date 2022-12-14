//
//  RegisterReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit
import PhotosUI
import RxSwift
import RxCocoa

final class RegisterReviewViewController: UIViewController {

    private var disposeBag = DisposeBag()
    private lazy var tagReviewViewModel = DefaultTagReviewViewModel()
    private lazy var outerCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: compositionalLayout())
    private let collectionViewBottomInset: CGFloat = 80

    private let phPickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10
        let phPickerVC = PHPickerViewController(configuration: configuration)
        return phPickerVC
    }()

    private let registerButton: CTAButton = {
        let button = CTAButton()
        button.setTitle("등록하기", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "리뷰 쓰기"
        view.backgroundColor = .white
        setUpCollectionView()
        layout()
        addKeyboardNotification()
    }

    private func setUpCollectionView() {
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

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
           let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        outerCollectionView.contentInset = .init(top: 0, left: 0, bottom: keyboardRect.height + collectionViewBottomInset, right: 0)
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
            return tagReviewViewModel.tags.count
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.storeInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoreInfoCell.reuseIdentifier,
                for: indexPath) as? StoreInfoCell else { return UICollectionViewCell() }
            cell.setUpContents(storeName: "가게이름", storeLocationInfo: "가게위치")
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
            cell.setUpContents(image: UIImage(),
                               title: tagReviewViewModel.tags[indexPath.row].title)
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
        return tagReviewViewModel.shouldSelectCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tagReviewViewModel.didSelectItemAt(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        tagReviewViewModel.didDeselectItemAt(indexPath: indexPath)
    }
}

// MARK: - ReviewPhotoDelegate
extension RegisterReviewViewController: ReviewPhotoDelegate {
    func imageAddButtonTapped() {
        present(phPickerViewController, animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
