//
//  Cancellable.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation
import Kingfisher

protocol Cancellable {
    func cancel()
    func resume()
}

extension URLSessionDataTask: Cancellable { }

extension Task: Cancellable {
    func resume() {}
}

extension Kingfisher.DownloadTask: Cancellable {
    func resume() { }
}
