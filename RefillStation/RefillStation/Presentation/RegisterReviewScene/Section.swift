//
//  Section.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit

extension ReviewWritingViewController {
    enum Section: Int, CaseIterable {
        case storeInfo
        case voteTitle
        case tagReview
        case photoReview
        case reviewDescription
        case registerButton

        var layoutSection: NSCollectionLayoutSection {
            let defaultItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let defaultItem = NSCollectionLayoutItem(layoutSize: defaultItemSize)
            defaultItem.contentInsets = .init(top: 5, leading: 16, bottom: 5, trailing: 16)
            var section: NSCollectionLayoutSection

            switch self {
            case .storeInfo:
                defaultItem.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .voteTitle:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .tagReview:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                      heightDimension: .absolute(42))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(42))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 0)
                group.interItemSpacing = .fixed(6)
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
            case .photoReview:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .reviewDescription:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            case .registerButton:
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(70))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [defaultItem])
                section = NSCollectionLayoutSection(group: group)
            }

            return section
        }
    }
}
