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
    case serviceTerms
    case location
    case privacyPolicy

    var title: String {
        switch self {
        case .serviceTerms:
            return "서비스 이용약관"
        case .location:
            return "위치기반 서비스 이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        }
    }
    var content: String {
        switch self {
        case .serviceTerms:
            return TermsLiterals.serviceTerms
        case .location:
            return TermsLiterals.location
        case .privacyPolicy:
            return TermsLiterals.privacyPolicy
        }
    }
}
