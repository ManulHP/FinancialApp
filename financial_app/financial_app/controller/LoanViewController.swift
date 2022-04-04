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

        // disable the default keyboard
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
        }
    }
    
    private func getFirstResponder() -> UITextField {
        let textfield = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfield
    }
    

}

extension LoanViewController: ReusableProtocol {
    func didPressDecemial(_ value: String) {
        print(".")
        let firstResponder = getFirstResponder()
        if var inputText = firstResponder.text{
            if !inputText.contains(".") && inputText.count > 0 {
                inputText += "."
                firstResponder.text = inputText
            }
        }
        
    }
    
    func didPressNumber(_ number: String) {
        print(number)
        let firstResponder = getFirstResponder()
        if var inputText = firstResponder.text{
            inputText += number
            firstResponder.text = inputText
        }
    }

    func didPressDelete() {
        print("DEL")
        let firstResponder = getFirstResponder()
        if !(firstResponder.text?.isEmpty ?? false){
            _ = firstResponder.text?.removeLast()
        }
    }
    
    
}
