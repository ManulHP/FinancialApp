//
//  HistoryViewController.swift
//  financial_app
//
//  Created by user214203 on 4/8/22.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var loanHistory: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        loanHistory = UserDefaults.standard.array(forKey: "LOAN") as! [String]
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loanHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "History")
        var content = cell?.defaultContentConfiguration()
        content?.text = loanHistory[indexPath.row]
        cell?.contentConfiguration = content
        return cell!
    }
    
    
}
