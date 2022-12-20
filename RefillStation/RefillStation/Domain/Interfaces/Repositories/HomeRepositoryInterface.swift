//
//  HomeRepositoryInterface.swift
//  RefillStation
//
//  Created by kong on 2022/12/16.
//

import Foundation

protocol HomeRepositoryInterface {
    func fetchStoreList(query: FetchStoreListUseCaseRequestValue,
                        completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
    func searchStoreList(query: SearchStoreListUseCaseRequestValue,
                         completion: @escaping (Result<[Store], Error>) -> Void) -> Cancellable?
}
