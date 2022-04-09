//
//  CompoundSavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class CompoundSavingViewController: UIViewController {

    @IBOutlet var keyboard: ReusableView!
    
    
    @IBOutlet var noOfPaymentsTF: UITextField!
    @IBOutlet var futureValueTF: UITextField!
    @IBOutlet var monthlyPaymentTF: UITextField!
    @IBOutlet var interestTF: UITextField!
    @IBOutlet var principalAmountTF: UITextField!
    
    var textfields: [UITextField] {
        return [noOfPaymentsTF, futureValueTF, monthlyPaymentTF, interestTF, principalAmountTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboard.delegate = self

        // Do any additional setup after loading the view.
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
        }
    }
    
    private func getFirstResponder() -> UITextField {
        let textfieldRespond = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfieldRespond
    }
    
    private func resetTf() {
        principalAmountTF.text = ""
        futureValueTF.text = ""
        monthlyPaymentTF.text = ""
        interestTF.text = ""
        noOfPaymentsTF.text = ""
    }
    
    private func calculateCompoundSaving() {
        let P = Double(principalAmountTF.text!)
        let I = Double(interestTF.text!)
        let FV = Double(futureValueTF.text!)
        let NP = Double(noOfPaymentsTF.text!)
        let CI = Double(12)
        
        var missingValue = 0.0
        
    }

}

extension CompoundSavingViewController: ReusableProtocol {
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
