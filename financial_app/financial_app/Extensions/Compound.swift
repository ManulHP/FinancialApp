//
//  Compound.swift
//  financial_app
//
//  Created by user214203 on 4/9/22.
//

import Foundation
import UIKit

/// operations of the compound screen are listed below
/// t ± time in years (synonymous with number of payments)
/// r (%) ± interest rate ± for simple savings only1
/// P ± present value
/// PMT ± Payment
/// A ± future value

extension UIViewController {
    ///finding the principal amount or the present ammount
    func findPrincipalAmount(interest: Double, compoundInterest: Double, futureValue: Double, noOfYears: Double, paymentValue: Double) -> Double {
        var output: Double
        var interestValue = interest / 100
        
        output = (futureValue - (paymentValue * (pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))) / pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears)
        return round(output * 100) / 100
    }
    
    /// finding the future value
    func findFutureValue(principalAmount: Double, interest: Double, compoundInterest: Double, noOfYears: Double, paymentValue: Double) -> Double {
        var output: Double
        var interestValue = interest / 100
        
        output = principalAmount * pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) + (paymentValue * (pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))
        return round(output * 100) / 100

    }
    
    ///finding the monthly amount
    func findMonthlyAmount(principalAmount: Double, interest: Double, compoundInterest: Double, futureValue: Double, noOfYears: Double) -> Double {
        var output: Double
        var interestValue = interest / 100
        
        output = futureValue - (principalAmount * pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears)) / ((pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))
        return round(output * 100) / 100

    }
    
    /// finding the number of payments
    func findNumberOfPayment(principalAmount: Double, interest: Double, compoundInterest: Double, futureValue: Double, paymentValue: Double) -> Double {
        var output: Double
        var interestValue = interest / 100
        
        output = (log(futureValue + ((paymentValue * compoundInterest) / interestValue)) - log(((interestValue * principalAmount) + (paymentValue * compoundInterest)) / interestValue)) / (compoundInterest * log(1 + (interestValue / compoundInterest)))
        return round(output * 100)  / 100

    }

}
