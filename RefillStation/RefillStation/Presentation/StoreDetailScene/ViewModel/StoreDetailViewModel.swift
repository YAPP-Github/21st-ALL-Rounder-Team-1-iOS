//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit

final class StoreDetailViewModel {

    // MARK: - Binding
    var applyDataSource: (() -> Void)?

    // MARK: - TabBarMode
    var mode: TabBarMode = .productLists {
        didSet { operationInfoSeeMoreIndexPaths.removeAll() }
    }

    // MARK: - Store Info
    var store: Store

    // MARK: - ProductList
    var products: [Product] = MockEntityData.products()
    private(set) var categories = [ProductCategory]()
    private(set) var currentCategoryFilter = ProductCategory.all
    var filteredProducts: [Product] {
        let filtered = products.filter({
            if currentCategoryFilter == ProductCategory.all {
                return true
            } else {
                return $0.category == currentCategoryFilter
            }
        })
        return filtered
    }

    // MARK: - Review
    var reviews = MockEntityData.reviews() {
        didSet {
            setUpRankedTags()
        }
    }
    var totalTagVoteCount = 5
    var rankTags = [RankTag]()

    // MARK: - Operation Info
    lazy var operationInfos: [OperationInfo] = {
        var operationInfos = [OperationInfo]()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        let today = dateFormatter.string(from: Date())

        let todayInfo: String = {
            if let today = self.store.businessHour.filter({ $0.day.name == today }).first {
                return "\(today.day.name) \(today.time ?? "정기 휴무일") \n\n"
            }
            return ""
        }()

        let businessHourInfo = todayInfo
        + store.businessHour
            .filter { $0.day.name != today }
            .sorted {
                return $0.day.rawValue < $1.day.rawValue
            }
            .reduce(into: "") { partialResult, businessHour in
                partialResult += "\(businessHour.day.name) \(businessHour.time ?? "정기 휴무일") \n"
            }
        + "\n"
        + store.notice

        return [
            OperationInfo(image: Asset.Images.iconClock.image.withRenderingMode(.alwaysTemplate),
                          content: businessHourInfo),
            OperationInfo(image: Asset.Images.iconOperationCall.image.withRenderingMode(.alwaysTemplate),
                          content: store.phoneNumber),
            OperationInfo(image: Asset.Images.iconOperationLink.image.withRenderingMode(.alwaysTemplate),
                          content: store.snsAddress),
            OperationInfo(image: Asset.Images.iconLocation.image.withRenderingMode(.alwaysTemplate),
                          content: store.address)
        ]
    }()
    var operationInfoSeeMoreIndexPaths = Set<IndexPath>()

    // MARK: - UseCase
    private let fetchProductsUseCase: FetchProductsUseCaseInterface
    private var productListLoadTask: Cancellable?
    private let fetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface
    private var storeReviewsLoadTask: Cancellable?
    private let recommendStoreUseCase: RecommendStoreUseCaseInterface
    private var recommendStoreTask: Cancellable?

    init(
        store: Store,
        fetchProductsUseCase: FetchProductsUseCaseInterface = FetchProductsUseCase(),
        fetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface = FetchStoreReviewsUseCase(),
        recommendStoreUseCase: RecommendStoreUseCaseInterface = RecommendStoreUseCase()
    ) {
        self.store = store
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchStoreReviewsUseCase = fetchStoreReviewsUseCase
        self.recommendStoreUseCase = recommendStoreUseCase
        setUpCategories()
        setUpRankedTags()
    }

    func categoryButtonDidTapped(category: ProductCategory?) {
        guard let category = category else { return }
        currentCategoryFilter = category
    }

    func operationInfoSeeMoreTapped(indexPath: IndexPath) {
        if operationInfoSeeMoreIndexPaths.contains(indexPath) {
            operationInfoSeeMoreIndexPaths.remove(indexPath)
        } else {
            operationInfoSeeMoreIndexPaths.insert(indexPath)
        }
    }

    func storeLikeButtonTapped() {
        let requestType: RecommendStoreRequestValue.`Type` = store.didUserRecommended ? .cancel : .recommend
        recommendStoreTask = recommendStoreUseCase.execute(
            requestValue: .init(storeId: store.storeId, type: requestType)
        ) { result in
            switch result {
            case .success(let response):
                self.store.recommendedCount = response.recommendCount
                self.store.didUserRecommended = response.didRecommended
                self.applyDataSource?()
            case .failure(let error):
                return // TODO: Show Alert
            }
        }

        recommendStoreTask?.resume()
    }

    private func setUpCategories() {
        products.forEach {
            if !categories.contains($0.category) {
                categories.append($0.category)
            }
        }
    }

    private func fetchProducts(storeId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        productListLoadTask = fetchProductsUseCase
            .execute(requestValue: FetchProductsRequestValue(storeId: storeId)) { result in
                switch result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        productListLoadTask?.resume()
    }

    private func cancelFetchingProducts() {
        productListLoadTask?.cancel()
    }

    private func setUpRankedTags() {
        var rankTagDict = [Tag: Int]()
        Tag.allCases.forEach {
            rankTagDict.updateValue(0, forKey: $0)
        }

        totalTagVoteCount = reviews.reduce(into: 0) { partialResult, review in
            partialResult += review.tags.contains(.noKeywordToChoose) ? 0 : 1
        }

        reviews.flatMap {
            return $0.tags
        }.forEach {
            if let voteCount = rankTagDict[$0] {
                rankTagDict.updateValue(voteCount + 1, forKey: $0)
            }
        }

        rankTags = rankTagDict.filter {
            $0.value != 0 && $0.key != .noKeywordToChoose
        }.sorted {
            if $0.value == $1.value {
                return $0.key.text < $1.key.text
            } else {
                return $0.value > $1.value
            }
        }.map {
            return RankTag(tag: $0.key, voteCount: $0.value)
        }
    }
}

// MARK: - Enums
extension StoreDetailViewModel {
    enum TabBarMode {
        case productLists
        case reviews
        case operationInfo

        var name: String {
            switch self {
            case .productLists:
                return "판매상품"
            case .reviews:
                return "리뷰"
            case .operationInfo:
                return "운영정보"
            }
        }
    }

    enum StoreInfoButtonType {
        case phone
        case link
        case like

        var image: UIImage? {
            switch self {
            case .phone:
                return Asset.Images.iconCall.image
            case .link:
                return Asset.Images.iconLink.image
            case .like:
                return Asset.Images.iconThumbsup.image
            }
        }

        var title: String {
            switch self {
            case .phone:
                return "전화"
            case .link:
                return "매장"
            case .like:
                return "추천"
            }
        }
    }
}

extension StoreDetailViewModel {
    struct RankTag: Hashable {
        let tag: Tag
        var voteCount: Int
    }
}
