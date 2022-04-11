//
//  CustomTableViewCell.swift
//  financial_app
//
//  Created by user214203 on 4/11/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var heading: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
       }
}
