//
//  DefaultTagReviewViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit

protocol TagReviewViewModelInput {
}

protocol TagReviewViewModelOutput {
}

protocol TagReviewViewModel: TagReviewViewModelInput, TagReviewViewModelOutput { }

final class DefaultTagReviewViewModel: TagReviewViewModel {

    let storeId: Int
    let storeName: String
    let storeLocationInfo: String
    var reviewPhotos: [UIImage] = []
    var reviewContents: String = ""
    var tags = Tag.allCases
    var totalReviewCount = 0
    var levelUppedLevel: UserLevelInfo.Level? {
        return UserLevelInfo.Level.allCases.first(where: { $0.levelUpTriggerCount == totalReviewCount })
    }
    var indexPathsForSelectedItems = [IndexPath]()
    var shouldSelectCell: Bool {
        return indexPathsForSelectedItems.count < 3 && !noKeywordTagDidSelected
    }
    var noKeywordTagDidSelected: Bool = false
    private var selectedTags: [Int] {
        return indexPathsForSelectedItems.map { Int($0.row) }
    }

    var reviewCountFetchCompleted: (() -> Void)?

    private let registerReviewUseCase: RegisterReviewUseCaseInterface
    private var registerReviewTask: Cancellable?
    private let fetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface
    private var userReviewsLoadTask: Cancellable?

    init(storeId: Int,
         storeName: String,
         storeLocationInfo: String,
         registerReviewUseCase: RegisterReviewUseCaseInterface = RegisterReviewUseCase(),
         fetchUserReviewsUseCase: FetchUserReviewsUseCaseInterface = FetchUserReviewsUseCase()
    ) {
        self.storeId = storeId
        self.storeName = storeName
        self.storeLocationInfo = storeLocationInfo
        self.registerReviewUseCase = registerReviewUseCase
        self.fetchUserReviewsUseCase = fetchUserReviewsUseCase
    }

    func didSelectItemAt(indexPath: IndexPath) {
        if tags[indexPath.row] == .noKeywordToChoose {
            noKeywordTagDidSelected = true
            indexPathsForSelectedItems = [indexPath]
        } else {
            indexPathsForSelectedItems.append(indexPath)
        }
    }

    func didDeselectItemAt(indexPath: IndexPath) {
        if tags[indexPath.row] == .noKeywordToChoose { noKeywordTagDidSelected = false }
        if let indexPathToRemove = indexPathsForSelectedItems.firstIndex(of: indexPath) {
            indexPathsForSelectedItems.remove(at: indexPathToRemove)
        }
    }

    func setUpRegisterButtonState() -> Bool {
        return reviewPhotos.count > 0 || !reviewContents.isEmpty ||
        (!noKeywordTagDidSelected && indexPathsForSelectedItems.count > 0)
    }

    func registerButtonTapped() {
        let registerReviewTask = registerReviewUseCase.execute(
            requestValue: .init(
                storeId: storeId,
                tagIds: selectedTags,
                images: reviewPhotos,
                description: reviewContents
            )
        ) { result in
            switch result {
            case .success:
                self.fetchUserReviewCount()
            case .failure:
                break
            }
        }
        registerReviewTask?.resume()
    }

    private func fetchUserReviewCount() {
        userReviewsLoadTask = fetchUserReviewsUseCase.execute { result in
            switch result {
            case .success(let reviews):
                self.totalReviewCount = reviews.prefix(Int.random(in: 1...5)).count // TODO: 테스트 코드 삭제
                self.reviewCountFetchCompleted?()
            case .failure:
                break
            }
        }
        userReviewsLoadTask?.resume()
    }
}
