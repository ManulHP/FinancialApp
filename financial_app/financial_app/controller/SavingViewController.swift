//
//  SavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class SavingViewController: UIViewController {

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
        noOfPaymentsTF.text = ""
        futureValueTF.text = ""
        monthlyPaymentTF.text = ""
        interestTF.text = ""
        principalAmountTF.text = ""
    }
    
    private func calculateSaving() {
        let P = Double(principalAmountTF.text!)
        let I = Double(interestTF.text!)
        let MP = Double(monthlyPaymentTF.text!)
        let FV = Double(futureValueTF.text!)
        let NP = Double(noOfPaymentsTF.text!)
        let CI = Double(12)
        
        var missingValue = 0.0
        
        if (interestTF.text?.isEmpty)! {
            missingValue = findMissingInterest(presentValue: P!, compoundsPerYear: CI, futureValue: FV!, noOfYears: NP!)
            interestTF.text = String(missingValue)
        } else if (futureValueTF.text?.isEmpty)! {
            missingValue = findMissingFutureValue(presentValue: P!, interest: I!, compoundsPerYear: CI, noOfYears: NP!)
            futureValueTF.text = String(missingValue)
        } else if (noOfPaymentsTF.text?.isEmpty)! {
            missingValue = findMissingNumberOfPayments(presentValue: P!, interest: I!, compoundsPerYear: CI, futureValue: FV!)
            noOfPaymentsTF.text = String(missingValue)
        }else if (principalAmountTF.text?.isEmpty)! {
            missingValue = findMissingPresentValue(interest: I!, compoundsPerYear: CI, futureValue: FV!, noOfYears: NP!)
            principalAmountTF.text = String(missingValue)
        }
        
    }
    
   
    @IBAction func calculateMissingValue(_ sender: Any) {
        calculateSaving()
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
