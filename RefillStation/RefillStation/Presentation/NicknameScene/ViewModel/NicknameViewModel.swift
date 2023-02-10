//
//  NicknameViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/01/22.
//

import UIKit

final class NicknameViewModel {
    private let editProfileUseCase: EditProfileUseCaseInterface
    private let validNicknameUseCase: ValidNicknameUseCaseInterface
    private var user: User
    let viewType: ViewType

    private var editProfileTask: Cancellable?
    private var validNicknameTask: Cancellable?

    var didEditComplete: (() -> Void)?
    var isValidNickname: ((Bool) -> Void)?
    var didImageChanged: Bool = false

    var profileImage: String? {
        return user.imageURL
    }

    var userNickname: String {
        return user.name
    }

    var isDuplicated = false

    init(viewType: ViewType,
         user: User,
         editProfileUseCase: EditProfileUseCaseInterface,
         validNicknameUseCase: ValidNicknameUseCaseInterface) {
        self.viewType = viewType
        self.user = user
        self.editProfileUseCase = editProfileUseCase
        self.validNicknameUseCase = validNicknameUseCase
    }

    func setNicknameState(count: Int) -> NicknameState {
        if count == 0 {
            return .empty
        } else if count < 2 {
            return .underTwoCharacters
        } else if count > 20 {
            return .overTwentyCharacters
        } else {
            return .correct
        }
    }

    func isValidCharacters(string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasVaildCharacters() || isBackSpace == -92 { return true }
        return false
    }

    func confirmButtonDidTapped(nickname: String?,
                                profileImage: UIImage?) {
        editProfileTask = editProfileUseCase.execute(
            requestValue: EditProfileRequestValue(nickname: nickname ?? "",
                                                  rating: user.level.level.rawValue,
                                                  newImage: profileImage,
                                                  oldImagePath: user.imageURL,
                                                  didImageChanged: didImageChanged)
        ) { result in
            switch result {
            case .success(let user):
                self.user = user
                self.didEditComplete?()
            case .failure(_):
                return
            }
        }
        editProfileTask?.resume()
    }

    func validNickname(requestValue: String) {
        validNicknameTask = validNicknameUseCase.execute(
            requestValue: ValidNicknameRequestValue(nickname: requestValue)
        ) { result in
            switch result {
            case .success(let isDuplicated):
                self.isDuplicated = isDuplicated
                self.isValidNickname?(isDuplicated)
            case .failure(_):
                return
            }
        }
        validNicknameTask?.resume()
    }
}

fileprivate extension String {
    func hasVaildCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]$",
                                                options: .caseInsensitive)
            if regex.firstMatch(in: self,
                                options: NSRegularExpression.MatchingOptions.reportCompletion,
                                range: NSRange(location: 0, length: self.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}

extension NicknameViewModel {
    enum ViewType {
        case onboarding
        case myPage
    }

    enum NicknameState {
        case empty
        case underTwoCharacters
        case overTwentyCharacters
        case correct

        var description: String {
            switch self {
            case .empty:
                return "닉네임을 입력해주세요"
            case .underTwoCharacters:
                return "닉네임은 2자 이상 입력해주세요"
            case .overTwentyCharacters:
                return "닉네임은 20자 이하로 입력해주세요"
            case .correct:
                return ""
            }
        }
        var borderColor: CGColor {
            switch self {
            case .empty:
                return Asset.Colors.gray4.color.cgColor
            case .underTwoCharacters, .overTwentyCharacters:
                return Asset.Colors.error.color.cgColor
            case .correct:
                return Asset.Colors.gray4.color.cgColor
            }
        }
        var textColor: UIColor {
            switch self {
            case .empty:
                return Asset.Colors.gray3.color
            case .underTwoCharacters, .overTwentyCharacters:
                return Asset.Colors.error.color
            case .correct:
                return .clear
            }
        }
    }
}
