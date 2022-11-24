//
//  UIView+makeRounded.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
}
