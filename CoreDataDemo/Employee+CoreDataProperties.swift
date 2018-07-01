//
//  Employee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Abhishek on 04/08/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import CoreData

extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var empId: String?
    @NSManaged public var name: String?
    @NSManaged public var contact: Int64
    @NSManaged public var emailId: String?
    @NSManaged public var address: String?

}
