//
//  ReviewWritingViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit
import PhotosUI
import RxSwift
import RxCocoa

final class ReviewWritingViewController: UIViewController {

    private var disposeBag = DisposeBag()
    private lazy var reviewSelectingViewModel = makeMockViewModel()
    private lazy var outerCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: compositionalLayout())
    private let phPickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10
        let phPickerVC = PHPickerViewController(configuration: configuration)
        return phPickerVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCollectionView()
        layout()
        bind()
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
        outerCollectionView.register(ReviewRegisterCell.self,
                                     forCellWithReuseIdentifier: ReviewRegisterCell.reuseIdentifier)
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
        outerCollectionView.allowsMultipleSelection = true
        outerCollectionView.keyboardDismissMode = .onDrag
    }

    private func layout() {
        view.addSubview(outerCollectionView)

        outerCollectionView.snp.makeConstraints { collection in
            collection.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bind() {
        outerCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.reviewSelectingViewModel.didSelectItemAt(indexPath: indexPath)
        }).disposed(by: disposeBag)

        outerCollectionView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            self?.reviewSelectingViewModel.didDeSelectItemAt(indexPath: indexPath)
        }).disposed(by: disposeBag)
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
        outerCollectionView.contentInset = .init(top: 0, left: 0, bottom: keyboardRect.height, right: 0)

        outerCollectionView.scrollToItem(at: IndexPath(item: 0, section: Section.reviewDescription.rawValue),
                                         at: .top, animated: true)
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        outerCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewWritingViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.tagReview.rawValue:
            return reviewSelectingViewModel.reviews.count
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
            cell.setUpContents(title: reviewSelectingViewModel.reviews[indexPath.row].tagTitle)
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
        case Section.registerButton.rawValue:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewRegisterCell.reuseIdentifier,
                for: indexPath) as? ReviewRegisterCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewCompositionalLayout
extension ReviewWritingViewController {
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        configuration.contentInsetsReference = .readableContent

        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            return Section(rawValue: section)?.layoutSection
        }, configuration: configuration)
    }
}

//
extension ReviewWritingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return reviewSelectingViewModel.shouldSelectCell
    }
}

// MARK: - ReviewPhotoDelegate
extension ReviewWritingViewController: ReviewPhotoDelegate {
    func imageAddButtonTapped() {
        present(phPickerViewController, animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
