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
        case review(DetailReview)
        case reviewOverview([TagReview])
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
            case .operationInfo:
                return 2
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
            case .operationInfo:
                return OperationInfoCell.reuseIdentifier
            }
        }

        var cellHeight: CGFloat {
            switch self {
            case .storeDetailInfo:
                return 300
            case .tabBar:
                return 300
            case .productCategory:
                return 50
            case .filteredProductsCount:
                return 50
            case .productList:
                return 113
            case .reviewOverview:
                return 800
            case .review:
                return 1000
            case .operationInfo:
                return 300
            }
        }

        var contentInset: NSDirectionalEdgeInsets {
            switch self {
            case .storeDetailInfo, .reviewOverview, .review, .productCategory, .tabBar:
                return .zero
            default:
                return .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            }
        }
    }
}
