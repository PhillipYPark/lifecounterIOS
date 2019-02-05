//
//  HistoryViewController.swift
//  LifeCounter
//
//  Created by Phillip Park on 2/4/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    var historyArray = PlayerListTableViewController.GlobalVariable.historyArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell func")

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? TableCell else {
            return UITableViewCell()
        }
        cell.history.text = historyArray[indexPath.row]
        return cell
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

        


}
