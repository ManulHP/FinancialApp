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
    
    @IBOutlet var saveImage: UIImageView!
    @IBOutlet var loanImage: UIImageView!
    @IBOutlet var compoundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSettings()
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            saveImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.saveImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            saveImage.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            saveImage.backgroundColor = .black
        }
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            loanImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.loanImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            loanImage.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            loanImage.backgroundColor = .black
        }
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            compoundImage.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.compoundImage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            compoundImage.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            compoundImage.backgroundColor = .black
        }
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
