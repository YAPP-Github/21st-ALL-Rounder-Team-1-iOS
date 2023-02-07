//
//  TermsPermissionViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/01/29.
//

import UIKit

final class TermsPermissionViewModel {

    let requestValue: SignUpRequestValue

    init(requestValue: SignUpRequestValue) {
        self.requestValue = requestValue
    }

    func didAgreeAllAgreements(buttons: [UIButton]) -> Bool {
        return buttons.map { $0.isSelected }
            .allSatisfy { $0 == true }
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
