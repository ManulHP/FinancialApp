//
//  LoanModel.swift
//  financial_app
//
//  Created by user214203 on 4/11/22.
//

import Foundation

class LoanModel {
    var amount: Double
    var interest: Double
    var futureVAlue: Double
    var noPayments: Double

    init(amount: Double, interest: Double, futureVAlue: Double, noPayments:Double) {
        self.amount = amount
        self.interest = interest
        self.futureVAlue = futureVAlue
        self.noPayments = noPayments

    }

    
}

