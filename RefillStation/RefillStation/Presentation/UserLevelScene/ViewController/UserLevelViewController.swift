//
//  UserLevelViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/05.
//

import UIKit
import SnapKit

final class UserLevelViewController: UIViewController {
    private let viewModel: UserLevelViewModel

    private let levelCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(LevelCollectionViewCell.self,
                                forCellWithReuseIdentifier: LevelCollectionViewCell.reuseIdentifier
        )
        collectionView.register(LevelHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: LevelHeaderView.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    init(viewModel: UserLevelViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "회원 등급 안내"
        view.backgroundColor = .white
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
        bind()
        layout()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    private func bind() {
        viewModel.reloadData = {
            self.levelCollectionView.reloadData()
        }
    }

    private func layout() {
        view.addSubview(levelCollectionView)
        levelCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension UserLevelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserLevelInfo.Level.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LevelCollectionViewCell.reuseIdentifier,
            for: indexPath) as? LevelCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpContent(level: UserLevelInfo.Level.allCases[indexPath.row])
        return cell
    }}

extension UserLevelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 84)
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: LevelHeaderView.reuseIdentifier,
            for: indexPath) as? LevelHeaderView else { return UICollectionReusableView() }
        header.setUpContents(level: viewModel.userLevel, totalReviewCount: viewModel.totalReviewCount)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 390)
    }
}
