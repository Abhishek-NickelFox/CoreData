//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Abhishek on 04/08/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var contact: UITextField!
	@IBOutlet weak var address: UITextField!
	@IBOutlet weak var empId: UITextField!

	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@IBAction func saveDB(_ sender: Any) {
		
		let _ = DBManager.shared.fetchAllEmployee()
		
		let emp = EmployeeClass()
		emp.empId = String(Date().timeIntervalSinceNow)
        print(emp.empId ?? "")
		emp.name = name.text
		emp.emailId = email.text
		
		if let number = contact.text {
			emp.contact = Int64(number)
		}
		
		emp.address = address.text
		
        DBManager.shared.addEmployee(employee: emp)
		
//        let _ = DBManager.shared.updateEmployee(employee: emp)
		
		print("AFTRE UPDATE")
		
		let _ = DBManager.shared.fetchAllEmployee()
		
	}
	
	@IBAction func clearAction(_ sender: Any) {
//		DBManager.shared.getEmployee(empId: empId.text!)
//		DBManager.shared.fetchAllEmployee()
//		DBManager.shared.deleteEmployee(empId: "1012")
//		DBManager.shared.fetchAllEmployee()
	}

    @IBAction func listAction(_ sender: Any) {
        self.performSegue(withIdentifier: "listSegueId", sender: nil)
    }
    
}
