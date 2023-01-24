//
//  StoreDetailDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import UIKit

final class StoreDetailDIContainer: DIContainer {
    private let navigationController: UINavigationController
    private let networkService = NetworkService()
    private let store: Store

    init(navigationController: UINavigationController, store: Store) {
        self.navigationController = navigationController
        self.store = store
    }

    // MARK: - RegisterReview
    func makeRegisterReviewDIContainer() -> RegisterReviewDIContainer {
        return RegisterReviewDIContainer(
            navigationController: navigationController,
            storeName: store.name,
            storeLocationInfo: store.address
        )
    }

    // MARK: - Coordinator
    func makeStoreDetailCoordinator() -> StoreDetailCoordinator {
        return StoreDetailCoordinator(DIContainer: self,
                                      navigationController: navigationController)
    }

    // MARK: - Store Detail
    func makeStoreDetailViewController() -> StoreDetailViewController {
        return StoreDetailViewController(viewModel: makeStoreDetailViewModel())
    }

    func makeStoreDetailViewModel() -> StoreDetailViewModel {
        return StoreDetailViewModel(
            store: store,
            fetchProductListUseCase: makeFetchProductListUseCase()
        )
    }

    func makeFetchProductListUseCase() -> FetchProductListUseCase {
        return FetchProductListUseCase(productListRepository: makeProductListRepository())
    }

    func makeProductListRepository() -> ProductListRepository {
        return ProductListRepository(networkService: networkService)
    }

    func makeNoLinkPopUpViewController() -> PumpPopUpViewController {
        let noLinkPopUp = PumpPopUpViewController(title: nil, description: "매장 링크가 등록되지 않은 곳이에요")
        noLinkPopUp.addImageView { imageView in
            imageView.snp.makeConstraints {
                $0.height.equalTo(50)
            }
            imageView.image = Asset.Images.cryFace.image
        }
        noLinkPopUp.addAction(title: "확인") {
            noLinkPopUp.dismiss(animated: true)
        }
        return noLinkPopUp
    }

    func makeReportPopUpViewModel(reportedUserId: Int) -> ReviewReportPopUpViewModel {
        return ReviewReportPopUpViewModel(reportedUserId: reportedUserId)
    }

    func makeReportPopUpViewController(reportedUserId: Int) -> ReviewReportPopUpViewController {
        let reportPopUp = ReviewReportPopUpViewController(
            title: "어떤 이유로 신고하시나요?",
            description: nil,
            viewModel: makeReportPopUpViewModel(reportedUserId: reportedUserId)
        )
        return reportPopUp
    }

    func makeReportCompletePopUpViewController() -> PumpPopUpViewController {
        let reportedPopUp = PumpPopUpViewController(title: nil,
                                                    description: "해당 댓글이 신고처리 되었습니다.")
        reportedPopUp.addAction(title: "확인") {
            self.navigationController.dismiss(animated: true)
        }
        return reportedPopUp
    }

    func makeDetailPhotoReviewViewModel(photoURLs: [String?]) -> DetailPhotoReviewViewModel {
        return DetailPhotoReviewViewModel(photoURLs: photoURLs)
    }

    func makeDetailPhotoReviewViewController(photoURLs: [String?]) -> DetailPhotoReviewViewController {
        return DetailPhotoReviewViewController(viewModel: makeDetailPhotoReviewViewModel(photoURLs: photoURLs))
    }
}
