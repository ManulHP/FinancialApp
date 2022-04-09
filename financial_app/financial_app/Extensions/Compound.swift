//
//  Compound.swift
//  financial_app
//
//  Created by user214203 on 4/9/22.
//

import Foundation
import UIKit

extension UIViewController {
    func findMissingCompoundresentValue(paymentTimeIsBeginning: Bool, interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double, paymentValue: Double) -> Double {
           
//           let FV = Double(futureValue)
//           let PMT = Double(paymentValue)
           let I = Double(interest) / 100
//           let CPY = Double(compoundsPerYear)
//           let N = Double(noOfYears)
           
           var PV: Double
           
           if paymentTimeIsBeginning {
               PV = (futureValue - (paymentValue * (pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (I / compoundsPerYear)) * (1 + I / compoundsPerYear)) / pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears)
           } else {
               PV = (futureValue - (paymentValue * (pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears) - 1) / (I / compoundsPerYear))) / pow((1 + I / compoundsPerYear), compoundsPerYear * noOfYears)
           }
           
           return round(PV * 100) / 100
           
       }
}
