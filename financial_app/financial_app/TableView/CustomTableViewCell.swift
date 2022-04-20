//
//  CustomTableViewCell.swift
//  financial_app
//
//  Created by user214203 on 4/11/22.
//

import UIKit

/// Custome table view row which contains the heading and the sub heading
//t ± time in years (synonymous with number of payments)
//r (%) ± interest rate ± for simple savings only1
//P ± present value
//PMT ± Payment
//A ± future value
class CustomTableViewCell: UITableViewCell {

    @IBOutlet var heading: UILabel!
    @IBOutlet var subheading: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
        /// content padding
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
       }
}
