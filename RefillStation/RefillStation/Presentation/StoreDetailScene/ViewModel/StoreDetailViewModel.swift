//
//  StoreDetailViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/20.
//

import UIKit
import Algorithms

final class StoreDetailViewModel {

    // MARK: - Binding
    var applyDataSource: (() -> Void)?
    var applyDataSourceWithoutAnimation: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    // MARK: - TabBarMode
    var mode: TabBarMode = .productLists {
        didSet { operationInfoSeeMoreIndexPaths.removeAll() }
    }

    // MARK: - Store Info
    var store: Store

    // MARK: - ProductList
    var products = [Product]()
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
    var reviews = [Review]()
    var totalTagVoteCount = 0
    var rankTags = [RankTag]()
    var reviewSeeMoreIndexPaths = Set<IndexPath>()

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
        + (!(store.businessHour.isEmpty || store.notice.isEmpty) ? "\n" : "")
        + store.notice

        return [
            OperationInfo(type: .time, content: businessHourInfo),
            OperationInfo(type: .phoneNumber, content: store.phoneNumber),
            OperationInfo(type: .link, content: store.snsAddress),
            OperationInfo(type: .address, content: store.address)
        ].filter {
            !$0.content.isEmpty
        }
    }()
    var operationInfoSeeMoreIndexPaths = Set<IndexPath>()

    // MARK: - UseCase
    private let fetchProductsUseCase: FetchProductsUseCaseInterface
    private var productListLoadTask: Cancellable?
    private let fetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface
    private var storeReviewsLoadTask: Cancellable?
    private let recommendStoreUseCase: RecommendStoreUseCaseInterface
    private var recommendStoreTask: Cancellable?
    private let fetchStoreRecommendUseCase: FetchStoreRecommendUseCaseInterface
    private var storeRecommendLoadTask: Cancellable?

    // MARK: - Init
    init(
        store: Store,
        fetchProductsUseCase: FetchProductsUseCaseInterface = FetchProductsUseCase(),
        fetchStoreReviewsUseCase: FetchStoreReviewsUseCaseInterface = FetchStoreReviewsUseCase(),
        recommendStoreUseCase: RecommendStoreUseCaseInterface = RecommendStoreUseCase(),
        fetchStoreRecommendUseCase: FetchStoreRecommendUseCaseInterface = FetchStoreRecommendUseCase()
    ) {
        self.store = store
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchStoreReviewsUseCase = fetchStoreReviewsUseCase
        self.recommendStoreUseCase = recommendStoreUseCase
        self.fetchStoreRecommendUseCase = fetchStoreRecommendUseCase
    }

    // MARK: - Input
    func categoryButtonDidTapped(category: ProductCategory?) {
        guard let category = category else { return }
        currentCategoryFilter = category
    }

    func reviewSeeMoreTapped(indexPath: IndexPath) {
        reviewSeeMoreIndexPaths.insert(indexPath)
    }

    func operationInfoSeeMoreTapped(indexPath: IndexPath) {
        if operationInfoSeeMoreIndexPaths.contains(indexPath) {
            operationInfoSeeMoreIndexPaths.remove(indexPath)
        } else {
            operationInfoSeeMoreIndexPaths.insert(indexPath)
        }
    }

    func storeLikeButtonTapped() {
        guard isAbleToRecommend() else { return }
        let requestType: RecommendStoreRequestValue.`Type` = store.didUserRecommended ? .cancel : .recommend
        recommendStoreTask = Task {
            do {
                let response = try await recommendStoreUseCase.execute(
                    requestValue: .init(storeId: store.storeId, type: requestType)
                )
                store.recommendedCount = response.recommendCount
                store.didUserRecommended = response.didRecommended
                applyDataSourceWithoutAnimation?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Private functions
    private func isAbleToRecommend() -> Bool {
        guard let lastRecommendedTime = UserDefaults.standard.object(forKey: "lastRecommended") as? Date else {
            UserDefaults.standard.set(Date(), forKey: "lastRecommended")
            return true
        }

        guard let dateToCompare = Calendar.current.date(
            byAdding: .nanosecond,
            value: 500_000_000,
            to: lastRecommendedTime
        ) else {
            return false
        }
        UserDefaults.standard.set(Date(), forKey: "lastRecommended")
        return dateToCompare < Date()
    }

    private func fetchProducts() {
        productListLoadTask = Task {
            do {
                let products = try await fetchProductsUseCase.execute(requestValue: .init(storeId: store.storeId))
                self.products = products
                setUpCategories()
                applyDataSourceWithoutAnimation?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }

    private func fetchStoreReviews() {
        let requestValue = FetchStoreReviewsRequestValue(storeId: store.storeId)
        storeReviewsLoadTask = Task {
            do {
                let reviews = try await fetchStoreReviewsUseCase.execute(requestValue: requestValue)
                if self.reviews != reviews {
                    self.reviews = reviews
                    setUpRankedTags()
                    applyDataSourceWithoutAnimation?()
                }
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }

    private func fetchStoreRecommend() {
        let requestValue = FetchStoreRecommendRequestValue(storeId: store.storeId)
        storeRecommendLoadTask = Task {
            do {
                let response = try await fetchStoreRecommendUseCase.execute(requestValue: requestValue)
                store.didUserRecommended = response.didRecommended
                store.recommendedCount = response.recommendCount
                applyDataSourceWithoutAnimation?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }

    private func setUpCategories() {
        products.forEach {
            if !categories.contains($0.category) {
                categories.append($0.category)
            }
        }
        categories.sort {
            switch ($0, $1) {
            case (.all, _),
                (_, _) where $1.title == "기타":
                return true
            case (_, .all),
                (_, _) where $0.title == "기타":
                return false
            default:
                return $0.title < $1.title
            }
        }
    }

    private func setUpRankedTags() {
        let tags = reviews.lazy.flatMap { $0.tags }
        totalTagVoteCount = reviews.filter {
            $0.tags != [.noKeywordToChoose] && !$0.tags.isEmpty
        }.count
        rankTags = Tag.allCases
            .filter { $0 != .noKeywordToChoose }
            .map { tag in
                RankTag(tag: tag, voteCount: tags.filter { $0 == tag }.count)
            }
            .sorted {
                $0.voteCount == $1.voteCount ? $0.tag.text < $1.tag.text : $0.voteCount > $1.voteCount
            }
    }
}

// MARK: - Life Cycle
extension StoreDetailViewModel {
    func viewDidLoad() {
        fetchProducts()
        fetchStoreRecommend()
    }

    func viewWillAppear() {
        fetchStoreReviews()
    }

    func viewWillDisappear() {
        [productListLoadTask, storeReviewsLoadTask, recommendStoreTask, storeRecommendLoadTask].forEach { $0?.cancel() }
    }
}

// MARK: - Enums
extension StoreDetailViewModel {
    enum TabBarMode {
        case productLists
        case reviews
        case operationInfo
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
        let voteCount: Int
    }
}
