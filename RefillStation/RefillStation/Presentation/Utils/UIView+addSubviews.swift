//
//  UIView+addSubviews.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
