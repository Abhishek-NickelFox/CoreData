//
//  CoreDataService.swift
//  CoreDataDemo
//
//  Created by Abhishek on 04/08/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit
import CoreData

class CoreDataService: NSObject {

	static let shared = CoreDataService()
	
	//******************************************************************  MARK: - Core Data stack (iOS >= 10) ******************************************************************
	
	@available(iOS 10.0, *)
	lazy var persistentContainer: NSPersistentContainer = {

		let container = NSPersistentContainer(name: "CoreDataDemo")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	// MARK: - Core Data Saving support
	
	func saveContext () {
		let context = self.dbContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	//****************************************************************** Common NSManagedObjectContext Getter *****************************************************************

	lazy var dbContext : NSManagedObjectContext = {
		if #available(iOS 10.0, *) {
			return self.persistentContainer.viewContext
		} else {
			return self.managedObjectContext
		}
	}()
	
	//******************************************************************  MARK: - Core Data stack (iOS < 10) ******************************************************************
	
	lazy var managedObjectContext: NSManagedObjectContext = {
		let coordinator = self.persistentStoreCoordinator
		var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator
		return managedObjectContext
	}()
	
	lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
		} catch {
			var dict = [String: AnyObject]()
			dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
			dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
			
			dict[NSUnderlyingErrorKey] = error as NSError
			let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
			print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
			abort()
		}
		
		return coordinator
	}()
	
	lazy var applicationDocumentsDirectory: NSURL = {
		let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return urls[urls.count - 1] as NSURL
	}()
	
	lazy var managedObjectModel: NSManagedObjectModel = {
		let modelURL = Bundle.main.url(forResource: "CoreDataDemo", withExtension: "momd")!
		return NSManagedObjectModel(contentsOf: modelURL)!
	}()
	
}
