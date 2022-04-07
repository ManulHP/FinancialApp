//
//  AlertMessage.swift
//  financial_app
//
//  Created by user214203 on 4/7/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertBox = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        
        alertBox.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertBox, animated: true, completion: nil)
    }
}
