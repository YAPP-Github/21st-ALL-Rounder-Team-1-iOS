//
//  RepositoryError.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/05.
//

import Foundation

enum RepositoryError: Error {
    case urlParseFailed
    case requestParseFailed
    case imageUploadFailed
}
