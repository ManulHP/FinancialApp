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
            let PMT = monthlyPayment
            let R = (interest / 100.0) / 12
            let N = noOfPay
            let P = (PMT / R) * (1 - (1 / pow(1 + R, N)))
            return round(100 * P) / 100
        }
    
    func calMissingMonthlyPayment(interest: Double, loanAmount: Double, noOfPay: Double) -> Double {
            let R = (interest / 100.0) / 12
            let P = loanAmount
            let N = noOfPay
            let PMT = (R * P) / (1 - pow(1 + R, -N))
            return round(100 * PMT) / 100
        }
    
    func calMissingNoOfPayment(interest: Double, loanAmount: Double, monthlyPayment: Double) -> Double {
            /// To find the minimum monthly payment
            let minMonthlyPayment = calMissingMonthlyPayment(interest: interest, loanAmount: loanAmount, noOfPay: 1) - loanAmount
                        
            let PMT = monthlyPayment
            let P = loanAmount
            let I = (interest / 100.0) / 12
            let D = PMT / I
            let N = (log(D / (D - P)) / log(1 + I))
            return round(100 * N) / 100
        }
    
    func calMissingLoanInterest(loanAmount: Double, monthlyPayment: Double, noOfPayment: Double) -> Double {
            /// initial calculation
            var x = 1 + (((monthlyPayment*noOfPayment/loanAmount) - 1) / 12)
            /// var x = 0.1;
            let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
            
            func F(_ x: Double) -> Double { // f(x)
                /// (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
                return Double(loanAmount * x * pow(1 + x, noOfPayment) / (pow(1+x, noOfPayment) - 1) - monthlyPayment);
            }
                                
            func FPrime(_ x: Double) -> Double { // f'(x)
                /// (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
                let c_derivative = pow(x+1, noOfPayment)
                return Double(loanAmount * pow(x+1, noOfPayment-1) *
                    (x * c_derivative + c_derivative - (noOfPayment*x) - x - 1)) / pow(c_derivative - 1, 2)
            }
            
            while(abs(F(x)) > FINANCIAL_PRECISION) {
                x = x - F(x) / FPrime(x)
            }

            let R = Double(12 * x * 100)

        
            if R.isNaN || R.isInfinite || R < 0 {
                return 0.00;
            } else {
            
              return round(100 * R) / 100
            }
        }
    
    
    
    
}
