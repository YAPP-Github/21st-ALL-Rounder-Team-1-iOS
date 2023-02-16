//
//  UIViewControllerExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/12.
//

import UIKit

protocol ServerAlertable {
    associatedtype CoordinatorProtocol: Coordinator
    var coordinator: CoordinatorProtocol? { get }
}

extension ServerAlertable where Self: UIViewController {

    func showServerErrorAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let popUp = PumpPopUpViewController(title: title, description: message)
            popUp.addAction(title: "확인", style: .basic) {
                popUp.dismiss(animated: true)
            }
            self.present(popUp, animated: false)
        }
    }

    func showNeedToLoginAlert() {
        DispatchQueue.main.async {
            let popUp = PumpPopUpViewController(title: "로그인이 필요해요", description: "로그인 페이지로 이동하시겠어요?")
            popUp.addAction(title: "취소", style: .cancel) {
                popUp.dismiss(animated: true)
            }
            popUp.addAction(title: "확인", style: .basic) {
                self.coordinator?.showLoginPage()
            }
            self.present(popUp, animated: false)
        }
    }
}
