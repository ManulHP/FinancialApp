//
//  CalViewController.swift
//  financial_app
//
//  Created by user214203 on 3/17/22.
//

import UIKit

class CalViewController: UIViewController {

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var loanView: UIView!
    @IBOutlet var saveView: UIView!
    @IBOutlet var compoundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func swtichControl(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0{
            saveView.alpha = 1
            loanView.alpha = 0
            compoundView.alpha = 0
        }else if segmentControl.selectedSegmentIndex == 1 {
            compoundView.alpha = 1
            saveView.alpha = 0
            loanView.alpha = 0
        }else {
            compoundView.alpha = 0
            saveView.alpha = 0
            loanView.alpha = 1
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
