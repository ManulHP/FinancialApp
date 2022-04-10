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
    
    private func validationTextField() -> Int{
        var count = 0
        
        if !(principalAmountTF.text?.isEmpty)! {
            count += 1
        }
        if !(interestTF.text?.isEmpty)! {
            count += 1
        }
        if !(monthlyPaymentTF.text?.isEmpty)! {
            count += 1
        }
        if !(futureValueTF.text?.isEmpty)! {
            count += 1
        }
        if !(noOfPaymentsTF.text?.isEmpty)! {
            count += 1
        }
        
        return count
    }
    
    private func resetTf() {
        principalAmountTF.text = ""
        futureValueTF.text = ""
        monthlyPaymentTF.text = ""
        interestTF.text = ""
        noOfPaymentsTF.text = ""
    }
    
    private func calculateCompoundSaving() {
        let PRINCIPAL_AMOUNT = Double(principalAmountTF.text!)
        let INTEREST = Double(interestTF.text!)
        let MONTHLY_PAYMENT = Double(monthlyPaymentTF.text!)
        let FUTURE_VALUE = Double(futureValueTF.text!)
        let NUMBER_PAYMENTS = Double(noOfPaymentsTF.text!)
        let COMPOUND_INTEREST = Double(12)
        
        var missingValue = 0.0
        
        if (principalAmountTF.text?.isEmpty)! {
            missingValue = findPrincipalAmount(interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, noOfYears: NUMBER_PAYMENTS!, paymentValue: MONTHLY_PAYMENT!)
            principalAmountTF.text = String(missingValue)
        }else if (futureValueTF.text?.isEmpty)! {
            missingValue = findFutureValue(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, noOfYears: NUMBER_PAYMENTS!, paymentValue: MONTHLY_PAYMENT!)
            futureValueTF.text = String(missingValue)
        }else if (monthlyPaymentTF.text?.isEmpty)! {
            missingValue = findMonthlyAmount(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, noOfYears: NUMBER_PAYMENTS!)
            monthlyPaymentTF.text = String(missingValue)
        }else if (noOfPaymentsTF.text?.isEmpty)! {
            missingValue = findNumberOfPayment(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, paymentValue: MONTHLY_PAYMENT!)
            noOfPaymentsTF.text = String(missingValue)
        }
        
    }
    
    
    @IBAction func didPressReset(_ sender: Any) {
        resetTf()
    }
    
    @IBAction func didPressCalculate(_ sender: UIButton) {
        if (validationTextField() == 0) {
            showAlert(title: "WARNING", message: "Please fill the fields")
        } else if (validationTextField() == 4){
            calculateCompoundSaving()
        } else if validationTextField() == 5 {
            showAlert(title: "WARNING", message: "Keep one field empty for conversion")
        }
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
