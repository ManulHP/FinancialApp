//
//  SavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class SavingViewController: UIViewController {

    @IBOutlet var keyboard: ReusableView!
    
    
    @IBOutlet var noOfPayments: UITextField!
    @IBOutlet var futureValue: UITextField!
    @IBOutlet var monthlyPayment: UITextField!
    @IBOutlet var interest: UITextField!
    @IBOutlet var principalAmount: UITextField!
    
    var textfields: [UITextField] {
        return [noOfPayments, futureValue, monthlyPayment, interest, principalAmount]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert(title: "WARNING", message: "Please keep one field empty to get the results")

        keyboard.delegate = self
        
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
        noOfPayments.text = ""
        futureValue.text = ""
        monthlyPayment.text = ""
        interest.text = ""
        principalAmount.text = ""
    }
    
    private func calculateSaving() {
        
    }
    
   

    @IBAction func resetBtn(_ sender: Any) {
        resetTf()
    }
    

}

extension SavingViewController: ReusableProtocol {
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
