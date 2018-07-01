//
//  EmpTableViewController.swift
//  CoreDataDemo
//
//  Created by Abhishek on 30/06/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

class EmpTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension EmpTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ID")!
        cell.textLabel?.text = "HEy"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
