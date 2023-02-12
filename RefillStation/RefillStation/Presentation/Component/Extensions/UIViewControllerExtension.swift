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
