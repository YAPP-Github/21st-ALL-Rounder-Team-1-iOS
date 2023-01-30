//
//  TermsPermissionViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/01/29.
//

import UIKit

final class TermsPermissionViewModel {
    func isEntireAgree(buttons: [UIButton]) -> Bool {
        for button in buttons where !button.isSelected {
            return false
        }
        return true
    }
}

enum TermsType: CaseIterable {
    case privacyPolicy
    case serviceTerms

    var title: String {
        switch self {
        case .privacyPolicy:
            return "개인정보 처리방침"
        case .serviceTerms:
            return "이용약관"
        }
    }
    var content: String {
        switch self {
        case .privacyPolicy:
            return TermsLiterals.privacyPolicy
        case .serviceTerms:
            return TermsLiterals.serviceTerms
        }
    }
}
