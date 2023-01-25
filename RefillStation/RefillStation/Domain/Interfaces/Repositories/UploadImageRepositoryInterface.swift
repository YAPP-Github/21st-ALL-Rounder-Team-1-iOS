//
//  UploadImageRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import UIKit

protocol UploadImageRepositoryInterface {
    func uploadImage(images: [UIImage], completion: @escaping (Result<[String], Error>) -> Void) -> Cancellable?
}
