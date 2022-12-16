//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/16.
//

import Foundation

protocol Coordinator: AnyObject {
    var DIContainer: DIContainer { get }

    func start()
}
