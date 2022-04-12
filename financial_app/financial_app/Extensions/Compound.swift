//
//  Compound.swift
//  financial_app
//
//  Created by user214203 on 4/9/22.
//

import Foundation
import UIKit

extension UIViewController {
    func findPrincipalAmount(interest: Double, compoundInterest: Double, futureValue: Double, noOfYears: Double, paymentValue: Double) -> Double {
            var output: Double
        
            var interestValue = interest / 100
            
            output = (futureValue - (paymentValue * (pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))) / pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears)
            
            return round(output * 100) / 100
        }
    
    func findFutureValue(principalAmount: Double, interest: Double, compoundInterest: Double, noOfYears: Double, paymentValue: Double) -> Double {
            var output: Double
           
            var interestValue = interest / 100

            output = principalAmount * pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) + (paymentValue * (pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))

           return round(output * 100) / 100

       }
    
    func findMonthlyAmount(principalAmount: Double, interest: Double, compoundInterest: Double, futureValue: Double, noOfYears: Double) -> Double {
            var output: Double
        
            var interestValue = interest / 100

        output = futureValue - (principalAmount * pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears)) / ((pow((1 + interestValue / compoundInterest), compoundInterest * noOfYears) - 1) / (interestValue / compoundInterest))

            return round(output * 100) / 100

        }
    
    func findNumberOfPayment(principalAmount: Double, interest: Double, compoundInterest: Double, futureValue: Double, paymentValue: Double) -> Double {
            var output: Double
        
            var interestValue = interest / 100

            output = (log(futureValue + ((paymentValue * compoundInterest) / interestValue)) - log(((interestValue * principalAmount) + (paymentValue * compoundInterest)) / interestValue)) / (compoundInterest * log(1 + (interestValue / compoundInterest)))

            return round(output * 100)  / 100

        }

}
