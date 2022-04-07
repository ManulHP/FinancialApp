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

            let PV = Double(presentValue)
            let FV = Double(futureValue)
            let CPY = Double(compoundsPerYear)
            let N = Double(noOfYears)
            let I = Double(CPY * (pow(FV / PV, (1 / (CPY * N))) - 1))
            
        
            return round((I * 100) * 100) / 100

        }
    
    func findMissingFutureValue(presentValue: Double, interest: Double, compoundsPerYear: Double, noOfYears: Double) -> Double {

            let PV = Double(presentValue)
            let I = Double(interest) / 100
            let N = Double(noOfYears)
            let CPY = Double(compoundsPerYear)
            let FV = Double(PV * (pow((1 + I / CPY), CPY * N)))

           return round(FV * 100) / 100

        }
    
    func findMissingNumberOfPayments(presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double) -> Double {

            let PV = Double(presentValue)
            let FV = Double(futureValue)
            let I = Double(interest) / 100
            let CPY = Double(compoundsPerYear)
            let N = Double(log(FV / PV) / (CPY * log(1 + (I / CPY))))

            return round(N * 100) / 100

        }
    
    
    func findMissingPresentValue(interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {

            let FV = Double(futureValue)
            let I = Double(interest) / 100
            let N = Double(noOfYears)
            let CPY = Double(compoundsPerYear)
            let PV = Double(FV / pow(1 + (I / CPY), CPY * N))

            return round(PV * 100) / 100

        }
}
