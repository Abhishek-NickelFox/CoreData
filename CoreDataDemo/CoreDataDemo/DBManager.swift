//
//  DBManager.swift
//  CoreDataDemo
//
//  Created by Abhishek on 04/08/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {

	static let shared = DBManager()
	
	public func addEmployee(employee: EmployeeClass) {
		
		let dbManager = CoreDataService.shared
		let context = dbManager.dbContext
		let entityDesc = NSEntityDescription.entity(forEntityName: "Employee", in: context)
		guard let entity = entityDesc else { return }
		let employeeObj = Employee(entity: entity, insertInto: context)
		
		employeeObj.empId = employee.empId
		employeeObj.name = employee.name
		employeeObj.address = employee.address
		employeeObj.contact = employee.contact!
		employeeObj.emailId = employee.emailId
		
		do {
			try context.save()
		} catch let error as NSError {
			print("Unable not save Employee \(error), \(error.userInfo)")
		}
	}
	
	public func fetchAllEmployee() -> [EmployeeClass] {
		
		let dbManager = CoreDataService.shared
		let context = dbManager.dbContext
		let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
		fetchRequest.entity = entity
		fetchRequest.fetchLimit = 30
		
		var resultArray: [EmployeeClass] = []
		
		do {
			let results = try context.fetch(fetchRequest) as! [Employee]
			
			for employee in results {
				
				let employeeObj = EmployeeClass()
				
				employeeObj.empId = employee.empId
				employeeObj.name = employee.name
				employeeObj.address = employee.address
				employeeObj.contact = employee.contact
				employeeObj.emailId = employee.emailId
				
				print("FETCH \(employeeObj.name)")
				print("ID \(employeeObj.empId)")
				print("\(employeeObj.address)")
				print("\(employeeObj.contact)")
				print("\(employeeObj.emailId)")
				
				resultArray.append(employeeObj)
			}
			
		} catch {
			let fetchError = error as NSError
			print(fetchError)
		}
		return resultArray
	}
	
	public func deleteEmployee(empId: String) {
		
		let dbManager = CoreDataService.shared
		let context = dbManager.dbContext
		let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
		fetchRequest.entity = entity
		let predicate = NSPredicate(format:"empId == %@", empId)
		fetchRequest.predicate = predicate
		
		do {
			let results = try context.fetch(fetchRequest)
			guard let obj = (results as? [Employee])?.first else { return }
			context.delete(obj)
			try context.save()
		} catch let error as NSError {
			print("Unable to Delete Employee \(error), \(error.userInfo)")
		}
	}
	
	public func updateEmployee(employee: EmployeeClass) -> Bool {
		
		guard let empId = employee.empId, let employeeObj = self.getEmployeeFromDB(empId: empId) else { return false }
		employeeObj.name = employee.name
		employeeObj.address = employee.address
		employeeObj.contact = employee.contact!
		employeeObj.emailId = employee.emailId
		
		let dbManager = CoreDataService.shared
		let context = dbManager.dbContext
		
		do {
			try context.save()
			return true
		} catch let error as NSError {
			print("Unable not Update Employee \(error), \(error.userInfo)")
		}
		
		return false
	}
	
	public func getEmployeeFromDB(empId: String) -> Employee? {
		
		let dbManager = CoreDataService.shared
		let context = dbManager.dbContext
		let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
		
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
		fetchRequest.entity = entity
		let predicate = NSPredicate(format:"empId == %@", empId)
		fetchRequest.predicate = predicate
		
		do {
			let results = try context.fetch(fetchRequest)
			guard let employee = (results as? [Employee])?.first else { return nil }
			return employee
		} catch let error as NSError {
			print("Unable to Fetch Employee \(error), \(error.userInfo)")
		}
		
		return nil
	}
	
	public func getEmployee(empId: String) -> EmployeeClass? {
		
		guard let employeeObj = self.getEmployeeFromDB(empId: empId) else { return nil }
		
		let employee = EmployeeClass()
		
		employee.empId = employeeObj.empId
		employee.name = employeeObj.name
		employee.address = employeeObj.address
		employee.contact = employeeObj.contact
		employee.emailId = employeeObj.emailId
		
		print("\(employee.name)")
		print("\(employee.address)")
		print("\(employee.contact)")
		print("\(employee.emailId)")
		
		return employee
	}
}
