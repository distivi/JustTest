//
//  UIViewController+Alert.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

protocol ShowAlert{}

extension ShowAlert where Self: UIViewController {
    func showAlert(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonTitle = NSLocalizedString("Ok", comment: "Ok")
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCommonErrorAlert() {
        self.showAlert(NSLocalizedString("Error", comment: "Error"),
                       message: NSLocalizedString("Ops, something went wrong", comment: "Ops, something went wrong"))
    }
    
    func showErrorAlert(_ message: String?) {
        self.showAlert(NSLocalizedString("Error", comment: "Error"),
                       message: message)
    }
}

