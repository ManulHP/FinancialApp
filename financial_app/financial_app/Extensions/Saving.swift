//
//  Saving.swift
//  financial_app
//
//  Created by user214203 on 4/7/22.
//

import Foundation
import UIKit

/// operations of the saving screen are listed below
/// t = time in years (synonymous with number of payments)
/// r (%) = interest rate ± for simple savings only
/// P = present value
/// PMT = Payment
/// A = future value

extension UIViewController {
    /// findiing the missing interest
    func findMissingInterest(presentValue: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {
        let I = (compoundsPerYear * (pow(futureValue / presentValue, (1 / (compoundsPerYear * noOfYears))) - 1))
        return round((I * 100) * 100) / 100

    }
    
    /// finding the missign fututre value
    func findMissingFutureValue(presentValue: Double, interest: Double, compoundsPerYear: Double, noOfYears: Double) -> Double {
        let I = interest / 100
        let FV = Double(presentValue * (pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears)))
        return round(FV * 100) / 100

    }
    
    /// finding the missing number of payments
    func findMissingNumberOfPayments(presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double) -> Double {
        let I = interest / 100
        let N = Double(log(futureValue / presentValue) / (compoundsPerYear * log(1 + (I / compoundsPerYear))))
        return round(N * 100) / 100

    }
    
    /// finding the missing present value or the principal amount
    func findMissingPresentValue(interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {
        let I = interest / 100
        let PV = (futureValue / pow(1 + (I / compoundsPerYear), compoundsPerYear * noOfYears))
        return round(PV * 100) / 100

    }
}
