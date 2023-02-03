//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit

final class HomeViewModel {
    private let fetchStoresUseCase: FetchStoresUseCaseInterface
    private var storeListLoadTask: Cancellable?
    var stores = [Store]()
    var isServiceRegion: Bool = false
    var setUpContents: (() -> Void)?

    init(fetchStoresUseCase: FetchStoresUseCaseInterface = FetchStoresUseCase()) {
        self.fetchStoresUseCase = fetchStoresUseCase
    }

    private func fetchStores() {
        storeListLoadTask = fetchStoresUseCase
            .execute(requestValue: FetchStoresUseCaseRequestValue(latitude: 100,
                                                                  longitude: 100)) { result in
                switch result {
                case .success(let stores):
                    self.stores = stores
                    self.setUpContents?()
                case .failure(let error):
                    break
                }
            }
        storeListLoadTask?.resume()
    }
}

extension HomeViewModel {
    func viewWillApeear() {
        fetchStores()
    }
}
