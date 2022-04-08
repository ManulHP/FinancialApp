//
//  AboutViewController.swift
//  financial_app
//
//  Created by user214203 on 4/3/22.
//

import UIKit

class AboutViewController: UIViewController {

    
    @IBOutlet var loanView: UIView!
    @IBOutlet var compoundView: UIView!
    @IBOutlet var saveView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSettings()
        // Do any additional setup after loading the view.
    }
    
    public func viewSettings() {
        saveView.layer.cornerRadius = 20
        saveView.layer.borderColor = UIColor.black.cgColor
        saveView.layer.borderWidth = 3.5
        saveView.layer.masksToBounds = true
        
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
