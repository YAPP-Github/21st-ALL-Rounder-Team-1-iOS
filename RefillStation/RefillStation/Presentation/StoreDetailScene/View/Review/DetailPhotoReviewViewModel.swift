//
//  DetailPhotoReviewViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/17.
//

import UIKit

final class DetailPhotoReviewViewModel {
    var page = 0 {
        didSet {
            if page != oldValue { setUpPageLabel?() }
        }
    }

    var setUpPageLabel: (() -> Void)?
    let photoURLs: [String?]

    init(photoURLs: [String?]) {
        self.photoURLs = photoURLs
    }

    func viewDidLoad() {
        fetchImages()
    }

    private func fetchImages() {

    }
}
