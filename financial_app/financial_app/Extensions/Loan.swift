//
//  Loan.swift
//  financial_app
//
//  Created by user214203 on 4/7/22.
//

import Foundation
import UIKit

extension UIViewController {
    func calMissingLoanAmount(interest: Double, monthlyPayment: Double, noOfPay: Double) -> Double {
            let R = (interest / 100) / 12
            let P = (monthlyPayment / R) * (1 - (1 / pow(1 + R, noOfPay)))
            return round(100 * P) / 100
        }
    
    func calMissingMonthlyPayment(interest: Double, loanAmount: Double, noOfPay: Double) -> Double {
            let R = (interest / 100) / 12
            let PMT = (R * loanAmount) / (1 - pow(1 + R, -noOfPay))
            return round(100 * PMT) / 100
        }
    
    func calMissingNoOfPayment(interest: Double, loanAmount: Double, monthlyPayment: Double) -> Double {
            let I = (interest / 100) / 12
            let D = monthlyPayment / I
            let N = (log(D / (D - loanAmount)) / log(1 + I))
            return round(100 * N) / 100
        }
    
    func calMissingLoanInterest(loanAmount: Double, noOfPay: Double, monthlyPayment: Double) -> Double {
            let I = (monthlyPayment * (pow(monthlyPayment / loanAmount, (1 / (monthlyPayment * noOfPay))) - 1))
        
            return round(I*100) / 100
        }
    
    
    
}
