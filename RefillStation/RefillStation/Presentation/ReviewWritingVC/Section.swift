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
            defaultItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            var section: NSCollectionLayoutSection

            switch self {
            case .storeInfo:
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
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1/4))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55),
                                                       heightDimension: .absolute(220))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
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
