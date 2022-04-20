//
//  LoanViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class LoanViewController: UIViewController {

    /// outlet for the resuable keyboard
    @IBOutlet var keyboard: ReusableView!
    
    // outlets for the textfield
    @IBOutlet var noOfPayamentsTF: UITextField!
    @IBOutlet var monthlyPaymentTF: UITextField!
    @IBOutlet var loanInterestTF: UITextField!
    @IBOutlet var loanAmountTF: UITextField!
    
    /// outlet for the buttons
    @IBOutlet var calculateBtn: UIButton!
    @IBOutlet var historyBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var resertBtn: UIButton!
    
    var saveHistory: [String]?
    /// textfield outlet collection
    var textfields: [UITextField] {
        return [loanAmountTF, loanInterestTF, monthlyPaymentTF, noOfPayamentsTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         /// display a pop up message
        showAlert(title: "WARNING", message: "Please keep one field empty to get the results")
        
        keyboard.delegate = self

        // disable the default iOS keyboard
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
            textfield.layer.cornerRadius = 10
            textfield.layer.borderWidth = 0.1
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "Amount") as? String{
            if value != nil {
                loanAmountTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "NoPayments") as? String{
            if value != nil {
                noOfPayamentsTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "Payment") as? String{
            if value != nil {
                monthlyPaymentTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "Interest") as? String{
            if value != nil {
                loanInterestTF.text = value
            }
        }
    }
    

    /// checks whether how many textfields are not empty
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
    
    /// getting the first responder
    private func getFirstResponder() -> UITextField {
        let textfieldRespond = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfieldRespond
    }

    /// calculates the missing values
    private func calculation() {
        let P = Double(loanAmountTF.text!) /// principal amount
        let R = Double(loanInterestTF.text!) // interest
        let PMT = Double(monthlyPaymentTF.text!) /// monthly paymnet
        let NP = Double(noOfPayamentsTF.text!) /// number of payments
        
        var missingValue = 0.0
        
        if (loanAmountTF.text?.isEmpty)! {
            /// finding the missing value when the principal amount field is empty
            missingValue = calMissingLoanAmount(interest: R!, monthlyPayment: PMT!, noOfPay: NP!)
            /// assigning the missing value to the principal amount textfield
            loanAmountTF.text = String(missingValue)
        }else if (monthlyPaymentTF.text?.isEmpty)! {
            /// finding the missing value when the monthly payment field is empty
            missingValue = calMissingMonthlyPayment(interest: R!, loanAmount: P!, noOfPay: NP!)
            /// assigning the missing value to the monthly paymentt textfield
            monthlyPaymentTF.text = String(missingValue)
        }else if (noOfPayamentsTF.text?.isEmpty)! {
            /// finding the missing value when the number of payment field is empty
            missingValue = calMissingNoOfPayment(interest: R!, loanAmount: P!, monthlyPayment: PMT!)
            /// assigning the missing value to the number of payment textfield
            noOfPayamentsTF.text = String(missingValue)
        }else if (loanInterestTF.text?.isEmpty)! {
            /// finding the missing value when the interest field is empty
            missingValue = calMissingLoanInterest(loanAmount: P!, noOfPay: NP!, monthlyPayment: PMT!)
            /// assigning the missing value to the interest textfield
            loanInterestTF.text = String(missingValue)
           
        }
        
        /// saving the last entered values  locally using user defaults
        UserDefaults.standard.set(loanAmountTF.text, forKey: "Amount") as? String
        UserDefaults.standard.set(loanInterestTF.text, forKey: "Interest") as? String
        UserDefaults.standard.set(monthlyPaymentTF.text, forKey: "Payment") as? String
        UserDefaults.standard.set(noOfPayamentsTF.text, forKey: "NoPayments") as? String
    }
    
    
    @IBAction func calculateMissingValue(_ sender: UIButton) {
        /// function executes only if the 3 textfiels are filled out of the 4 textfields.
        ///  if textfields entered is less than 3 then a pop up message appears
        ///  if all the textfields are entered again a pop up appears requesting to kepp on empty field
        if (validationTextField() < 3) {
            showAlert(title: "WARNING", message: "Please fill 3 fields to continue")
        } else if (validationTextField() == 3){
            calculation()
        } else if validationTextField() == 4 {
            showAlert(title: "WARNING", message: "Keep one field empty for conversion")
        }
        
    }
    
    /// reset the textfields
    @IBAction func restBtn(_ sender: UIButton) {
        loanAmountTF.text = ""
        loanInterestTF.text = ""
        monthlyPaymentTF.text = ""
        noOfPayamentsTF.text = ""
    }
    
    @IBAction func didPressSave(_ sender: Any) {
        /// onlys saves the data if all the textfields are filled otherwise a pop message appears
        if validationTextField() <= 3 {
            showAlert(title: "WARNING", message: "Can't save the data because all 4 fields needs to be filled")
        }else if validationTextField() == 4 {
            var saveString = "P: \(loanAmountTF.text)\nI: \(loanInterestTF.text)\nPMT: \(monthlyPaymentTF.text)\nN: \(noOfPayamentsTF.text)"
            
            saveHistory(saveString: saveString)
        }
    }
    
    /// save function
    private func saveHistory(saveString: String) {
        /// save data
        if var saveValue = UserDefaults.standard.array(forKey: "LOAN") as? [String] {
            if saveValue.count > 7 {
                _ = saveValue.removeFirst()
            }
            saveValue.append(saveString)
            UserDefaults.standard.set(saveValue, forKey: "LOAN")
        } else {
            UserDefaults.standard.set([saveString], forKey: "LOAN")
        }
        
        /// display a pop up message
        showAlert(title: "Successful", message: "Data entered are saved")

    }
    
}

/// reusable keyboard protocol
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
