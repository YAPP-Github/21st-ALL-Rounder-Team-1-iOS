//
//  ImageUploadTask.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/08.
//

import Foundation

final class ImageUploadTask: Cancellable {
    var task: (() -> Void)?

    init(task: @escaping (() -> Void)) {
        self.task = task
    }

    func resume() {
        self.task?()
    }

    func cancel() {
        task = nil
    }
}
