//
//  AboutViewController.swift
//  financial_app
//
//  Created by user214203 on 4/3/22.
//

import UIKit

/// details of the help section
class AboutViewController: UIViewController {

    
    @IBOutlet var loanView: UIView!
    @IBOutlet var compoundView: UIView!
    @IBOutlet var saveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSettings()
        
    }
    
    public func viewSettings() {
        saveView.layer.cornerRadius = 20 // raduis == 20
        saveView.layer.borderColor = UIColor.black.cgColor // border color == black
        saveView.layer.borderWidth = 3.5 // border width == 3.5
        saveView.layer.masksToBounds = true // sublayers clipped together
        
        compoundView.layer.cornerRadius = 20
        compoundView.layer.borderColor = UIColor.black.cgColor
        compoundView.layer.borderWidth = 3.5
        compoundView.layer.masksToBounds = true
        
        loanView.layer.cornerRadius = 20
        loanView.layer.borderColor = UIColor.black.cgColor
        loanView.layer.borderWidth = 3.5
        loanView.layer.masksToBounds = true
    }

}
