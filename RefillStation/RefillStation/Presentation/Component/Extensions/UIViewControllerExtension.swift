//
//  UIViewControllerExtension.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/12.
//

import UIKit

protocol ServerAlertable { }

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
}

protocol LoginAlertable {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType? { get }
}

extension LoginAlertable where Self: UIViewController {
    func loginFeatureButtonTapped(
        shouldShowPopUp: Bool,
        title: String?,
        description: String?
    ) {
        DispatchQueue.main.async { [weak self] in
            if !shouldShowPopUp {
                self?.coordinator?.showLookAroundLogin()
                return
            }
            let popUp = PumpPopUpViewController(title: title, description: description)
            popUp.addAction(title: "취소", style: .cancel) {
                popUp.dismiss(animated: true)
            }
            popUp.addAction(title: "로그인", style: .basic) {
                self?.dismiss(animated: true) { [weak self] in
                    self?.coordinator?.showLookAroundLogin()
                }
            }
            self?.present(popUp, animated: false)
        }
    }
}
