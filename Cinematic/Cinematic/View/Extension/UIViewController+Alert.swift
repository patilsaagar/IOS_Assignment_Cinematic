//
//  UIViewController+Alert.swift
//  Cinematic
//
//  Created by sagar patil on 21/04/2022.
//

import UIKit

extension UIViewController {
    func showAlert(alertTitle: String, alertMessgae: String) {
        let alertViewController = UIAlertController(title: alertTitle, message: alertMessgae, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: Constants.alertOkButtonTitle, style: .default, handler: nil))
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}
