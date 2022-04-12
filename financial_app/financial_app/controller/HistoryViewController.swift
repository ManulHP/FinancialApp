import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var loanHistory = [SaveHistory]()
    var saveHistory = [SaveHistory]()
    var compoundHistory = [SaveHistory]()

    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    var index = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension

        /// tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        
        getSaveString()
    }
    
    public func getSaveString(){
        let saveList = UserDefaults.standard.array(forKey: "SAVE") as? [String]
        let loanList = UserDefaults.standard.array(forKey: "LOAN") as? [String]
        let compundList = UserDefaults.standard.array(forKey: "COMPOUND") as? [String]
        
        if saveList?.count ?? 0 > 0 {
            for item in saveList! {
                print(item)
                let history = SaveHistory(savedString: item)
                
                saveHistory += [history]
            }
        }
        
        if loanList?.count ?? 0 > 0 {
            for item in loanList! {
                print(item)
                let history = SaveHistory(savedString: item)
                
                loanHistory += [history]
            }
        }
        
        if compundList?.count ?? 0 > 0 {
            for item in compundList! {
                print(item)
                let history = SaveHistory(savedString: item)
                
                compoundHistory += [history]
            }
            
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
            count = compoundHistory.count
        } else if index == 2 {
            count = loanHistory.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath) as? CustomTableViewCell
        var content = cell?.defaultContentConfiguration()
        if index == 0 {
            cell?.heading.text =  String(saveHistory[indexPath.row].savedString)
            cell?.subheading.text = "P - Present Value I - Interest F - Future Value N - No. of Payments"
        } else if index == 1 {
            cell?.heading.text =  String(compoundHistory[indexPath.row].savedString)
            cell?.subheading.text = "P - Present Value I - Interest PMT - Payment N - No. of Payments"
            cell?.subheading.text = "P - Present Value I - Interest PMT - Payment N - No. of Payments F - Future Value"
        } else if index == 2 {
            cell?.heading.text =  String(loanHistory[indexPath.row].savedString)
            cell?.subheading.text = "P - Present Value I - Interest PMT - Payment N - No. of Payments"
        }
        
        
//        cell?.contentConfiguration = content
        return cell!
    }
    
    
}
