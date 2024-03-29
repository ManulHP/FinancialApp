//
//  SavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class SavingViewController: UIViewController {
    
    /// outlet for the resuable keyboard
    @IBOutlet var keyboard: ReusableView!
    
    /// outlets for the textfields
    @IBOutlet var principalAmountTF: UITextField!
    @IBOutlet var noOfPaymentsTF: UITextField!
    @IBOutlet var futureValueTF: UITextField!
    @IBOutlet var interestTF: UITextField!
    
    /// creating a outlet collection
    var textfields: [UITextField] {
        return [noOfPaymentsTF, futureValueTF, interestTF, principalAmountTF]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Displays a alert message
        showAlert(title: "WARNING", message: "Please keep one field empty to get the results")

        keyboard.delegate = self
        
        /// hides the default keyboard wthen the board in active
        textfields.forEach { textfield in
            textfield.inputView = UIView()
            textfield.inputAccessoryView = UIView()
            textfield.layer.cornerRadius = 10
            textfield.layer.borderWidth = 0.1
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "AmountSave") as? String{
            if value != nil {
                principalAmountTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "NoPaymentsSave") as? String{
            if value != nil {
                noOfPaymentsTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "PaymentSave") as? String{
            if value != nil {
                futureValueTF.text = value
            }
        }
        
        /// checks the userdaults to see whether there is a value assign to the specific key, if there's a value then that particular value is assign to the textfield as the default value
        if let value = UserDefaults.standard.value(forKey: "InterestSave") as? String{
            if value != nil {
                interestTF.text = value
            }
        }

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
        if !(futureValueTF.text?.isEmpty)! {
            count += 1
        }
        if !(noOfPaymentsTF.text?.isEmpty)! {
            count += 1
        }
        
        return count
    }
    
    /// get's the first responder as a textfield
    private func getFirstResponder() -> UITextField {
        let textfieldRespond = textfields.filter { fResponder in
            return fResponder.isFirstResponder
        }.first!
        
        return textfieldRespond
    }
    
    /// resets the values to a empty string
    private func resetTf() {
        noOfPaymentsTF.text = ""
        futureValueTF.text = ""
        interestTF.text = ""
        principalAmountTF.text = ""
    }
    
    /// calculates the missing values
    private func calculateSaving() {
        let P = Double(principalAmountTF.text!) /// present amount field data
        let I = Double(interestTF.text!) /// interest  field data
        let FV = Double(futureValueTF.text!) /// future value field data
        let NP = Double(noOfPaymentsTF.text!) /// number of payment field data
        let CI = Double(12)
        
        var missingValue = 0.0
        
        if (interestTF.text?.isEmpty)! {
            /// finding the missing value when the interest field is empty
            missingValue = findMissingInterest(presentValue: P!, compoundsPerYear: CI, futureValue: FV!, noOfYears: NP!)
            /// assigning the missing value to the interest textfield
            interestTF.text = String(missingValue)
        } else if (futureValueTF.text?.isEmpty)! {
            /// finding the missing value when the future value field is empty
            missingValue = findMissingFutureValue(presentValue: P!, interest: I!, compoundsPerYear: CI, noOfYears: NP!)
            /// assigning the missing value to the future value textfield
            futureValueTF.text = String(missingValue)
        } else if (noOfPaymentsTF.text?.isEmpty)! {
            /// finding the missing value when the number of payments field is empty
            missingValue = findMissingNumberOfPayments(presentValue: P!, interest: I!, compoundsPerYear: CI, futureValue: FV!)
            /// assigning the missing value to the number of paymnets textfield
            noOfPaymentsTF.text = String(missingValue)
        }else if (principalAmountTF.text?.isEmpty)! {
            /// finding the missing value when the principal amount field is empty
            missingValue = findMissingPresentValue(interest: I!, compoundsPerYear: CI, futureValue: FV!, noOfYears: NP!)
            /// assigning the missing value to the principal amount textfield
            principalAmountTF.text = String(missingValue)
        }
        
        /// saving the last entered values  locally using user defaults
        UserDefaults.standard.set(principalAmountTF.text, forKey: "AmountSave") as? String
        UserDefaults.standard.set(interestTF.text, forKey: "InterestSave") as? String
        UserDefaults.standard.set(futureValueTF.text, forKey: "PaymentSave") as? String
        UserDefaults.standard.set(noOfPaymentsTF.text, forKey: "NoPaymentsSave") as? String
        
    }
    
    /// saving function
    private func saveHistory(saveString: String) {
        /// save the data locally
        if var saveValue = UserDefaults.standard.array(forKey: "SAVE") as? [String] {
            if saveValue.count > 7 {
                _ = saveValue.removeFirst()
            }
            saveValue.append(saveString)
            UserDefaults.standard.set(saveValue, forKey: "SAVE")
        } else {
            UserDefaults.standard.set([saveString], forKey: "SAVE")
        }
        
        /// showing a error message
        showAlert(title: "Successful", message: "Data entered are saved")

    }
    
    /// save button
    @IBAction func didPressSave(_ sender: Any) {
        /// onlys saves the data if all the textfields are filled otherwise a pop message appears
        if validationTextField() <= 3 {
            showAlert(title: "WARNING", message: "Can't save the data because all 4 fields needs to be filled")
        }else if validationTextField() == 4 {
            var saveString = "P: \(principalAmountTF.text)\n I: \(interestTF.text)\nF: \(futureValueTF.text)\nN: \(noOfPaymentsTF.text)"
            
            print(saveString)
            saveHistory(saveString: saveString)
        }
        
    }
    
    /// calculate button
    @IBAction func calculateMissingValue(_ sender: Any) {
        /// function executes only if the 3 textfiels are filled out of the 4 textfields.
        ///  if textfields entered is less than 3 then a pop up message appears
        ///  if all the textfields are entered again a pop up appears requesting to kepp on empty field
        if (validationTextField() < 3) {
            showAlert(title: "WARNING", message: "Please fill 3 fields to continue")
        } else if (validationTextField() == 3){
            calculateSaving()
        } else if validationTextField() == 4 {
            showAlert(title: "WARNING", message: "Keep one field empty for conversion")
        }
        
    }
    
    ///reset button
    @IBAction func resetBtn(_ sender: Any) {
        resetTf()
    }
    

}

/// reusable keyboard protocols
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
