//
//  SavingViewController.swift
//  financial_app
//
//  Created by user214203 on 4/2/22.
//

import UIKit

class SavingViewController: UIViewController {

    @IBOutlet var keyboard: ReusableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        keyboard.delegate = self
        // Do any additional setup after loading the view.
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

extension SavingViewController: ReusableProtocol {
    func didPressDecemial(_ value: String) {
        print(".")
    }
    
    func didPressNumber(_ number: String) {
        print(number)
    }

    func didPressDelete() {
        print("DEL")
    }
    
    
}
