//
//  LoanViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class LoanViewController: UIViewController {

    @IBOutlet var keyboard: ReusableView!
    
    
    @IBOutlet var noOfPayamentsTF: UITextField!
    @IBOutlet var monthlyPaymentTF: UITextField!
    @IBOutlet var loanInterestTF: UITextField!
    @IBOutlet var loanAmountTF: UITextField!
    
    var textfields: [UITextField] {
        return [loanAmountTF, loanInterestTF, monthlyPaymentTF, noOfPayamentsTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert()
        
        keyboard.delegate = self

        // disable the default iOS keyboard
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
        loanAmountTF.text = ""
        loanInterestTF.text = ""
        monthlyPaymentTF.text = ""
        noOfPayamentsTF.text = ""
    }
    
    private func calculation() {
        var P = Double(loanAmountTF.text!)
        var R = Double(loanInterestTF.text!)
        var PMT = Double(monthlyPaymentTF.text!)
        var NP = Double(noOfPayamentsTF.text!)
        
        var missingValue = 0.0
        
        if (loanAmountTF.text?.isEmpty)! {
            missingValue = calMissingLoanAmount(interest: R!, monthlyPayment: PMT!, noOfPay: NP!)
            loanAmountTF.text = String(missingValue)
        }else if (monthlyPaymentTF.text?.isEmpty)! {
            missingValue = calMissingMonthlyPayment(interest: R!, loanAmount: P!, noOfPay: NP!)
            monthlyPaymentTF.text = String(missingValue)
        }else if (noOfPayamentsTF.text?.isEmpty)! {
            missingValue = calMissingNoOfPayment(interest: R!, loanAmount: P!, monthlyPayment: PMT!)
            noOfPayamentsTF.text = String(missingValue)
        }else if (loanInterestTF.text?.isEmpty)! {
            missingValue = calMissingLoanInterest(loanAmount:P!, monthlyPayment: PMT!, noOfPayment: NP!)
            loanInterestTF.text = String(missingValue)
        }
    }
    
    
    @IBAction func calculateMissingValue(_ sender: UIButton) {
        calculation()
    }
    
    @IBAction func restBtn(_ sender: UIButton) {
        resetTf()
    }
    
    
    @IBAction func didPressSave(_ sender: Any) {
        print("Save")
        
        var saveString = "P: \(loanAmountTF.text)\nR: \(loanInterestTF.text)\nPMT: \(monthlyPaymentTF.text)\nNP: \(noOfPayamentsTF.text)"
        
        print(saveString)
        saveHistory(saveString: saveString)
    }
    
    private func saveHistory(saveString: String) {
        if var saveValue = UserDefaults.standard.array(forKey: "LOAN") as? [String] {
            if saveValue.count > 7 {
                _ = saveValue.removeFirst()
            }
            saveValue.append(saveString)
            UserDefaults.standard.set(saveValue, forKey: "LOAN")
        } else {
            UserDefaults.standard.set([saveString], forKey: "LOAN")
        }
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
