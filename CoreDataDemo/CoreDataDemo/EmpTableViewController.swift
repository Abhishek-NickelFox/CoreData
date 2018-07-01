//
//  EmpTableViewController.swift
//  CoreDataDemo
//
//  Created by Abhishek on 30/06/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import CoreData

class EmpTableViewController: UITableViewController {

    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Unable to Perform Fetch Request : \(error.localizedDescription)")
        }
        
        guard let results = self.fetchedResultsController.fetchedObjects else { return }
        self.employees = results
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Employee> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "empId", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: CoreDataService.shared.dbContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
}

extension EmpTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_ID")!
        cell.textLabel?.text = self.employees[indexPath.row].name
        print(self.employees[indexPath.row].empId)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count
    }
}

extension EmpTableViewController: NSFetchedResultsControllerDelegate {
    
    
}
