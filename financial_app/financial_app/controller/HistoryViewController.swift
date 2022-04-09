//
//  HistoryViewController.swift
//  financial_app
//
//  Created by user214203 on 4/8/22.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var loanHistory: [String]?
    var saveHistory: [String]?
    var compoundHistory: [String]?
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var index = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        loanHistory = UserDefaults.standard.array(forKey: "LOAN") as? [String]
        
        saveHistory = UserDefaults.standard.array(forKey: "SAVE") as? [String]
    }

    @IBAction func segmentIndex(_ sender: UISegmentedControl) {
        index = segmentControl.selectedSegmentIndex
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if index == 0 {
            count = saveHistory?.count ?? 0
        } else if index == 1 {
            count = 0
        } else if index == 2 {
            count = loanHistory?.count  ?? 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "History")
        var content = cell?.defaultContentConfiguration()
        if index == 0 {
            content?.text = saveHistory?[indexPath.row]
        } else if index == 1 {
            content?.text = loanHistory?[indexPath.row]
        } else if index == 2 {
            content?.text = loanHistory?[indexPath.row]
        }
        
        cell?.contentConfiguration = content
        return cell!
    }
    
    
}
