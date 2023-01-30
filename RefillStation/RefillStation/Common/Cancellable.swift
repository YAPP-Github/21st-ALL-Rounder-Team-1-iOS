//
//  Cancellable.swift
//  RefillStation
//
//  Created by kong on 2022/12/20.
//

import Foundation

protocol Cancellable {
    func cancel()
    func resume()
}
