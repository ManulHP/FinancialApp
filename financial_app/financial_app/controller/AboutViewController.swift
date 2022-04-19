//
//  AboutViewController.swift
//  financial_app
//
//  Created by user214203 on 4/3/22.
//

import UIKit

/// details of the help section
class AboutViewController: UIViewController {

    ///  outlets related to the view cards (save, compound, loan)
    @IBOutlet var loanView: UIView!
    @IBOutlet var compoundView: UIView!
    @IBOutlet var saveView: UIView!
    
    @IBOutlet var saveImage: UIImageView!
    @IBOutlet var loanImage: UIImageView!
    @IBOutlet var compoundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSettings()
        
        /// create a blur effect to the save image
        if !UIAccessibility.isReduceTransparencyEnabled {
            saveImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.saveImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            saveImage.addSubview(blurEffectView)
        } else {
            saveImage.backgroundColor = .black
        }
        
        /// create a blur effect to the loan  image
        if !UIAccessibility.isReduceTransparencyEnabled {
            loanImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.loanImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            loanImage.addSubview(blurEffectView)
        } else {
            loanImage.backgroundColor = .black
        }
        
        /// create a blur effect to the compound image
        if !UIAccessibility.isReduceTransparencyEnabled {
            compoundImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.compoundImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            compoundImage.addSubview(blurEffectView)
        } else {
            compoundImage.backgroundColor = .black
        }
    }
    
    public func viewSettings() {
        /// adding view properties to the save view
        saveView.layer.cornerRadius = 20 // raduis == 20
        saveView.layer.borderColor = UIColor.black.cgColor // border color == black
        saveView.layer.borderWidth = 3.5 // border width == 3.5
        saveView.layer.masksToBounds = true // sublayers clipped together
        
        /// adding view properties to the compound view
        compoundView.layer.cornerRadius = 20 // raduis == 20
        compoundView.layer.borderColor = UIColor.black.cgColor // border color == black
        compoundView.layer.borderWidth = 3.5 // border width == 3.5
        compoundView.layer.masksToBounds = true // sublayers clipped together
        
        /// adding view properties to the loan view
        loanView.layer.cornerRadius = 20 // raduis == 20
        loanView.layer.borderColor = UIColor.black.cgColor // border color == black
        loanView.layer.borderWidth = 3.5 // border width == 3.5
        loanView.layer.masksToBounds = true // sublayers clipped together
    }

}
