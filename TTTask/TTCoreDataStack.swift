//
//  TTCoreDataStack.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import Foundation
import CoreData

class TTCoreDataStack {
    private lazy var applicationDocumentsDirectory: NSURL = {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.last!
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("TTTask", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ToDos.sqlite")
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            var failureReason = "There was an error creating or loading the application's saved data."
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: TTErrorDomain, code: 9999, userInfo: dict)
        }
            return coordinator
        }()
    
    lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.undoManager = nil
        return managedObjectContext
    }()
    
    func saveContext () {
        if mainManagedObjectContext.hasChanges {
            do {
                try mainManagedObjectContext.save()
            } catch {
                let saveError = error as NSError
                print("Unresolved error \(saveError), \(saveError.userInfo)")
            }
        }
    }
}