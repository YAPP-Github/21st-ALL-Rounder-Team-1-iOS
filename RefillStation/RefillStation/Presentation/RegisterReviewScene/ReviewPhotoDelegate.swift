//
//  File.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit

protocol ReviewPhotoDelegate: AnyObject {
    func imageAddButtonTapped()
    func dismiss(reviewPhotos: [UIImage])
}
