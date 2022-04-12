//
//  Saving.swift
//  financial_app
//
//  Created by user214203 on 4/7/22.
//

import Foundation
import UIKit

extension UIViewController {
    func findMissingInterest(presentValue: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {

            let I = (compoundsPerYear * (pow(futureValue / presentValue, (1 / (compoundsPerYear * noOfYears))) - 1))
            
        
            return round((I * 100) * 100) / 100

        }
    
    func findMissingFutureValue(presentValue: Double, interest: Double, compoundsPerYear: Double, noOfYears: Double) -> Double {

        
            let I = interest / 100
        
            let FV = Double(presentValue * (pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears)))

           return round(FV * 100) / 100

        }
    
    func findMissingNumberOfPayments(presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double) -> Double {
            let I = interest / 100
            let N = Double(log(futureValue / presentValue) / (compoundsPerYear * log(1 + (I / compoundsPerYear))))

            return round(N * 100) / 100

        }
    
    
    func findMissingPresentValue(interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {
            let I = interest / 100
            let PV = (futureValue / pow(1 + (I / compoundsPerYear), compoundsPerYear * noOfYears))

            return round(PV * 100) / 100

        }
}
