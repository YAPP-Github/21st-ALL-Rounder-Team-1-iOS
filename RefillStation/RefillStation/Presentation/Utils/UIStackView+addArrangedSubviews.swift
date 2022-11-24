//
//  UIStackView+addArrangedSubviews.swift
//  RefillStation
//
//  Created by kong on 2022/11/24.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ view: [UIView]) {
        view.forEach { self.addArrangedSubview($0) }
    }
}
