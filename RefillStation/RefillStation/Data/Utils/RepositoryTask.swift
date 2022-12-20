//
//  RepositoryTask.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: Cancellable?
    var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
