//
//  StoreDetailSection.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/14.
//

import UIKit

extension StoreDetailViewController {
    enum StoreDetailItem: Hashable {
        case storeDetailInfo(Store)
        case productList(Product)
        case review(Review)
        case reviewOverview([StoreDetailViewModel.RankTag])
        case oprationNotice(String)
        case operationInfo(OperationInfo)
        case tabBarMode(StoreDetailViewModel.TabBarMode)
        case productCategory(ProductCategoriesCellInfo)
        case filteredProduct(Int)
    }

    enum StoreDetailSection: Int, CaseIterable {
        case storeDetailInfo
        case tabBar
        case productCategory
        case filteredProductsCount
        case productList
        case reviewOverview
        case review
        case operationNotice
        case operationInfo

        var sectionIndex: Int {
            switch self {
            case .storeDetailInfo:
                return 0
            case .tabBar:
                return 1
            case .productCategory:
                return 2
            case .filteredProductsCount:
                return 3
            case .productList:
                return 4
            case .reviewOverview:
                return 2
            case .review:
                return 3
            case .operationNotice:
                return 2
            case .operationInfo:
                return 3
            }
        }

        var cell: UICollectionViewCell.Type {
            switch self {
            case .storeDetailInfo:
                return StoreDetailInfoViewCell.self
            case .tabBar:
                return StoreDetailTabBarCell.self
            case .productCategory:
                return ProductCategoriesCell.self
            case .filteredProductsCount:
                return FilteredProductCountCell.self
            case .productList:
                return ProductCell.self
            case .reviewOverview:
                return ReviewInfoCell.self
            case .review:
                return DetailReviewCell.self
            case .operationNotice:
                return OperationNoticeCell.self
            case .operationInfo:
                return OperationInfoCell.self
            }
        }

        var reuseIdentifier: String {
            switch self {
            case .storeDetailInfo:
                return StoreDetailInfoViewCell.reuseIdentifier
            case .tabBar:
                return StoreDetailTabBarCell.reuseIdentifier
            case .productCategory:
                return ProductCategoriesCell.reuseIdentifier
            case .filteredProductsCount:
                return FilteredProductCountCell.reuseIdentifier
            case .productList:
                return ProductCell.reuseIdentifier
            case .reviewOverview:
                return ReviewInfoCell.reuseIdentifier
            case .review:
                return DetailReviewCell.reuseIdentifier
            case .operationNotice:
                return OperationNoticeCell.reuseIdentifier
            case .operationInfo:
                return OperationInfoCell.reuseIdentifier
            }
        }

        var cellHeight: CGFloat {
            switch self {
            case .storeDetailInfo:
                return 500
            case .tabBar:
                return 300
            case .productCategory:
                return 51
            case .filteredProductsCount:
                return 50
            case .productList:
                return 113
            case .reviewOverview:
                return 800
            case .review:
                return 100
            case .operationNotice:
                return 300
            case .operationInfo:
                return 300
            }
        }

        var contentInset: NSDirectionalEdgeInsets {
            switch self {
            case .storeDetailInfo, .reviewOverview, .review, .productCategory, .tabBar, .operationNotice:
                return .zero
            default:
                return .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            }
        }
    }

    func section(mode: StoreDetailViewModel.TabBarMode, sectionIndex: Int) -> StoreDetailSection {
        if sectionIndex == StoreDetailSection.storeDetailInfo.sectionIndex {
            return StoreDetailSection.storeDetailInfo
        } else if sectionIndex == StoreDetailSection.tabBar.sectionIndex {
            return StoreDetailSection.tabBar
        }

        switch (mode, sectionIndex) {
        case (.productLists, 2):
            return StoreDetailSection.productCategory
        case (.productLists, 3):
            return StoreDetailSection.filteredProductsCount
        case (.productLists, 4):
            return StoreDetailSection.productList
        case (.reviews, 2):
            return StoreDetailSection.reviewOverview
        case (.reviews, 3):
            return StoreDetailSection.review
        case (.operationInfo, 2):
            return StoreDetailSection.operationNotice
        case (.operationInfo, 3):
            return StoreDetailSection.operationInfo
        default:
            return .storeDetailInfo
        }
    }
}
