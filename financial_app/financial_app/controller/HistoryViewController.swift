//
//  HistoryViewController.swift
//  financial_app
//
//  Created by user214203 on 4/8/22.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var loanHistory = [SaveHistory]()
    var saveHistory = [SaveHistory]()
    var compoundHistory = [SaveHistory]()
    var saveHi: [String]?
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var index = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 88.0 
        self.tableView.rowHeight = UITableView.automaticDimension

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        
        getSaveString()
    }
    
    public func getSaveString(){
        let saveList = UserDefaults.standard.array(forKey: "SAVE") as? [String]
        
        let loanList = UserDefaults.standard.array(forKey: "LOAN") as? [String]
        
        for item in saveList! {
            print(item)
            let history = SaveHistory(savedString: item)
            
            saveHistory += [history]
        }
        
        for item in loanList! {
            print(item)
            let history = SaveHistory(savedString: item)
            
            loanHistory += [history]
        }
        
        
    }

    @IBAction func segmentIndex(_ sender: UISegmentedControl) {
        index = segmentControl.selectedSegmentIndex
        tableView.reloadData()
    }
    
    /// not working
    @IBAction func didPressDelete(_ sender: UIButton) {
        if index == 0 {
            UserDefaults.standard.set([], forKey: "SAVE")
//            showAlert(title: "DELETED", message: "Saved savings account calculations are deleted")
            tableView.reloadData()

        } else if index == 1 {
            print("Delete")
        } else if index == 2 {
            UserDefaults.standard.set([], forKey: "LOAN")
//            showAlert(title: "DELETED", message: "Saved loan account calculations are deleted")
            tableView.reloadData()

        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if index == 0 {
            count = saveHistory.count
        } else if index == 1 {
            count = 0
        } else if index == 2 {
            count = loanHistory.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath) as? CustomTableViewCell
        var content = cell?.defaultContentConfiguration()
        if index == 0 {
//            content?.text = saveHi?[indexPath.row]
            
            cell?.heading.text =  String(saveHistory[indexPath.row].savedString)
        } else if index == 1 {
//            content?.text = loanHistory?[indexPath.row]
        } else if index == 2 {
            cell?.heading.text =  String(loanHistory[indexPath.row].savedString)
        }
        
        
//        cell?.contentConfiguration = content
        return cell!
    }
    
    
}
