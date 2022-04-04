//
//  LoanViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class LoanViewController: UIViewController {

    @IBOutlet var keyboard: ReusableView!
    
    
    @IBOutlet var textfields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboard.delegate = self

        // disable the default iOS keyboard
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
        }
        
    }
    


}

extension LoanViewController: ReusableProtocol {
    func didPressDecemial(_ value: String) {
        print(".")
    }
    
    func didPressNumber(_ number: String) {
        print(number)
    }

    func didPressDelete() {
        print("DEL")
    }
    
    
}
