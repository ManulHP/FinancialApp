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
    
    @IBOutlet var calculateBtn: UIButton!
    @IBOutlet var historyBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var resertBtn: UIButton!
    
    var saveHistory: [String]?
    var items: [LoanModel] = []
    
    var textfields: [UITextField] {
        return [loanAmountTF, loanInterestTF, monthlyPaymentTF, noOfPayamentsTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert(title: "WARNING", message: "Please keep one field empty to get the results")
        
        keyboard.delegate = self

        // disable the default iOS keyboard
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
            textfield.layer.cornerRadius = 10
            textfield.layer.borderWidth = 0.1
        }
        
        if let value = UserDefaults.standard.value(forKey: "Amount") as? String{
            if value != nil {
                loanAmountTF.text = value
            }
            print(value)
        }
        
        if let value = UserDefaults.standard.value(forKey: "NoPayments") as? String{
            if value != nil {
                noOfPayamentsTF.text = value
            }
            print(value)
        }
        
        if let value = UserDefaults.standard.value(forKey: "Payment") as? String{
            if value != nil {
                monthlyPaymentTF.text = value
            }
            print(value)
        }
        
        if let value = UserDefaults.standard.value(forKey: "Interest") as? String{
            if value != nil {
                loanInterestTF.text = value
            }
            print(value)
        }
    }
    

    
    private func validationTextField() -> Int{
        var count = 0
        
        if !(noOfPayamentsTF.text?.isEmpty)! {
            count += 1
        }
        if !(monthlyPaymentTF.text?.isEmpty)! {
            count += 1
        }
        if !(loanInterestTF.text?.isEmpty)! {
            count += 1
        }
        if !(loanAmountTF.text?.isEmpty)! {
            count += 1
        }
        
        return count
    }
    
    private func getFirstResponder() -> UITextField {
        let textfieldRespond = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfieldRespond
    }
    
    private func getTextField(by tag: Int) -> UITextField? {
        let tf = textfields.filter {
            tf in return tf.tag == tag
        }.first
        return tf
    }
    
    private func resetTf() {
        loanAmountTF.text = ""
        loanInterestTF.text = ""
        monthlyPaymentTF.text = ""
        noOfPayamentsTF.text = ""
    }
    
    
    
    private func calculation() {
        let P = Double(loanAmountTF.text!)
        let R = Double(loanInterestTF.text!)
        let PMT = Double(monthlyPaymentTF.text!)
        let NP = Double(noOfPayamentsTF.text!)
        
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
        
        UserDefaults.standard.set(loanAmountTF.text, forKey: "Amount") as? String
        UserDefaults.standard.set(loanInterestTF.text, forKey: "Interest") as? String
        UserDefaults.standard.set(monthlyPaymentTF.text, forKey: "Payment") as? String
        UserDefaults.standard.set(noOfPayamentsTF.text, forKey: "NoPayments") as? String
    }
    
    
    @IBAction func calculateMissingValue(_ sender: UIButton) {
        if (validationTextField() == 0) {
            showAlert(title: "WARNING", message: "Please fill the fields")
        } else if (validationTextField() == 3){
            calculation()
        } else if validationTextField() == 4 {
            showAlert(title: "WARNING", message: "Keep one field empty for conversion")
        }
        
    }
    
    @IBAction func restBtn(_ sender: UIButton) {
        resetTf()
    }
    
    
    @IBAction func didPressSave(_ sender: Any) {
        print("Save")
        
        if validationTextField() <= 3 {
            showAlert(title: "WARNING", message: "Can't save the data because all 4 fields needs to be filled")
        }else if validationTextField() == 4 {
            var saveString = "P: \(loanAmountTF.text)\nI: \(loanInterestTF.text)\nPMT: \(monthlyPaymentTF.text)\nN: \(noOfPayamentsTF.text)"
            
            print(saveString)
            
            
            saveHistory(saveString: saveString)
        }
        
        
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
        
        showAlert(title: "Successful", message: "Data entered are saved")

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
