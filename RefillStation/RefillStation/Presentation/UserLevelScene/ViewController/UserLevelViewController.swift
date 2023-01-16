//
//  UserLevelViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/05.
//

import UIKit
import SnapKit

final class UserLevelViewController: UIViewController {
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "회원 등급 안내"
        view.backgroundColor = .white
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
        layout()
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
        header.setUpContents(nickname: "뿡빵뿡빵",
                             level: .beginner,
                             remainingCount: 5,
                             totalCount: 10)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 390)
    }
}
