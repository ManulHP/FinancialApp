//
//  TextField.swift
//  financial_app
//
//  Created by user214203 on 3/19/22.
//

import UIKit

class TextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

}
