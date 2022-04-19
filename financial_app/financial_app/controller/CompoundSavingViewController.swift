//
//  CompoundSavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class CompoundSavingViewController: UIViewController {

    /// outlet for the resuable keyboard
    @IBOutlet var keyboard: ReusableView!
    
    /// outlets for the textfields
    @IBOutlet var noOfPaymentsTF: UITextField!
    @IBOutlet var futureValueTF: UITextField!
    @IBOutlet var monthlyPaymentTF: UITextField!
    @IBOutlet var interestTF: UITextField!
    @IBOutlet var principalAmountTF: UITextField!
    
    /// creating a textfield outlet collection
    var textfields: [UITextField] {
        return [noOfPaymentsTF, futureValueTF, monthlyPaymentTF, interestTF, principalAmountTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboard.delegate = self

        /// disable the default keyboard
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
            textfield.layer.cornerRadius = 10
            textfield.layer.borderWidth = 0.1
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "AmountCompound") as? String{
            if value != nil {
                principalAmountTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "NoPaymentsCompound") as? String{
            if value != nil {
                noOfPaymentsTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "PaymentCompound") as? String{
            if value != nil {
                monthlyPaymentTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "InterestCompound") as? String{
            if value != nil {
                interestTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "FutureCompound") as? String{
            if value != nil {
                futureValueTF.text = value
            }
        }
    }
    
    /// getting the first responder
    private func getFirstResponder() -> UITextField {
        let textfieldRespond = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfieldRespond
    }
    
    /// checks whether how many textfields are not empty
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
    
    /// resets the values to a empty string
    private func resetTf() {
        principalAmountTF.text = ""
        futureValueTF.text = ""
        monthlyPaymentTF.text = ""
        interestTF.text = ""
        noOfPaymentsTF.text = ""
    }
    
    /// calculates the missing values
    private func calculateCompoundSaving() {
        let PRINCIPAL_AMOUNT = Double(principalAmountTF.text!)
        let INTEREST = Double(interestTF.text!)
        let MONTHLY_PAYMENT = Double(monthlyPaymentTF.text!)
        let FUTURE_VALUE = Double(futureValueTF.text!)
        let NUMBER_PAYMENTS = Double(noOfPaymentsTF.text!)
        let COMPOUND_INTEREST = Double(12)
        
        var missingValue = 0.0
        
        if (principalAmountTF.text?.isEmpty)! {
            /// finding the missing value when the principal amount field is empty
            missingValue = findPrincipalAmount(interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, noOfYears: NUMBER_PAYMENTS!, paymentValue: MONTHLY_PAYMENT!)
            /// assigning the missing value to the principal amount textfield
            principalAmountTF.text = String(missingValue)
        }else if (futureValueTF.text?.isEmpty)! {
            /// finding the missing value when the future amount field is empty
            missingValue = findFutureValue(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, noOfYears: NUMBER_PAYMENTS!, paymentValue: MONTHLY_PAYMENT!)
            /// assigning the missing value to the future amount textfield
            futureValueTF.text = String(missingValue)
        }else if (monthlyPaymentTF.text?.isEmpty)! {
            /// finding the missing value when the monthly payment field is empty
            missingValue = findMonthlyAmount(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, noOfYears: NUMBER_PAYMENTS!)
            /// assigning the missing value to the monthly payment textfield
            monthlyPaymentTF.text = String(missingValue)
        }else if (noOfPaymentsTF.text?.isEmpty)! {
            /// finding the missing value when the number of payments field is empty
            missingValue = findNumberOfPayment(principalAmount: PRINCIPAL_AMOUNT!, interest: INTEREST!, compoundInterest: COMPOUND_INTEREST, futureValue: FUTURE_VALUE!, paymentValue: MONTHLY_PAYMENT!)
            /// assigning the missing value to the number of payments textfield
            noOfPaymentsTF.text = String(missingValue)
        }else if (interestTF.text?.isEmpty)! {
            /// interest caluculation not done yet therefore returning 0 as the output
            showAlert(title: "Failed", message: "Interest calculations havent yet implemented")
            interestTF.text = String(missingValue)
        }
        
        /// saving the last entered values  locally using user defaults
        UserDefaults.standard.set(principalAmountTF.text, forKey: "AmountCompound") as? String
        UserDefaults.standard.set(interestTF.text, forKey: "InterestCompound") as? String
        UserDefaults.standard.set(monthlyPaymentTF.text, forKey: "PaymentCompound") as? String
        UserDefaults.standard.set(noOfPaymentsTF.text, forKey: "NoPaymentsCompound") as? String
        UserDefaults.standard.set(futureValueTF.text, forKey: "FutureCompound") as? String
        
    }
    
    /// save function
    private func saveHistory(saveString: String) {
        /// save the data locally
        if var saveValue = UserDefaults.standard.array(forKey: "COMPOUND") as? [String] {
            if saveValue.count > 7 {
                _ = saveValue.removeFirst()
            }
            saveValue.append(saveString)
            UserDefaults.standard.set(saveValue, forKey: "COMPOUND")
        } else {
            UserDefaults.standard.set([saveString], forKey: "COMPOUND")
        }
        
        /// showing a pop up message
        showAlert(title: "Successful", message: "Data entered are saved")

    }
     /// reset button
    @IBAction func didPressReset(_ sender: Any) {
        resetTf()
    }
    
    /// calculate button
    @IBAction func didPressCalculate(_ sender: UIButton) {
        /// function executes only if the 4 textfiels are filled out of the 4 textfields.
        ///  if textfields entered is less than 4 then a pop up message appears
        ///  if all the textfields are entered again a pop up appears requesting to kepp on empty field
        if (validationTextField() < 4) {
            showAlert(title: "WARNING", message: "Please fill 4 fields to continue")
        } else if (validationTextField() == 4){
            calculateCompoundSaving()
        } else if validationTextField() == 5 {
            showAlert(title: "WARNING", message: "Keep one field empty for conversion")
        }
    }
    
    /// save button
    @IBAction func didPressSave(_ sender: UIButton) {
        /// onlys saves the data if all the textfields are filled otherwise a pop message appears
        if validationTextField() <= 4 {
            showAlert(title: "WARNING", message: "Can't save the data because all 4 fields needs to be filled")
        }else if validationTextField() == 5 {
            var saveString = "P: \(principalAmountTF.text)\n I: \(interestTF.text)\nF: \(futureValueTF.text)\nN: \(noOfPaymentsTF.text)\nPMT: \(monthlyPaymentTF.text)"
            
            saveHistory(saveString: saveString)
        }
    }
    
}

/// reusable keyboard protocol
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
