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
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func saveDB(_ sender: Any) {
		
		DBManager.shared.fetchAllEmployee()
		
		let emp = EmployeeClass()
		emp.empId = empId.text
		emp.name = name.text
		emp.emailId = email.text
		
		print("REACH1 \(contact.text)")
		if let number = contact.text {
			emp.contact = Int64(number)
			print("REACH2 \(number)")
			print("REACH23 \(emp.contact)")
		}
		
		emp.address = address.text
		
//		DBManager.shared.addEmployee(employee: emp)
		
		DBManager.shared.updateEmployee(employee: emp)
		
		print("AFTRE UPDATE")
		
		DBManager.shared.fetchAllEmployee()
		
	}
	
	@IBAction func clearAction(_ sender: Any) {
//		DBManager.shared.getEmployee(empId: empId.text!)
//		DBManager.shared.fetchAllEmployee()
//		DBManager.shared.deleteEmployee(empId: "1012")
		
//		print("AFGRE")
//		DBManager.shared.fetchAllEmployee()
	}

}

// /Users/abhishek/Desktop/CoreDataMedium/CoreDataDemo/CoreDataDemo/ViewController.swift:35:35: Type of expression is ambiguous without more context
