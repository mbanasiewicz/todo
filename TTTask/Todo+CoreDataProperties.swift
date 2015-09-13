//
//  Todo+CoreDataProperties.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 12/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Todo {

    @NSManaged var completed: NSNumber?
    @NSManaged var createdAt: NSDate?
    @NSManaged var notes: String?
    @NSManaged var order: NSNumber?
    @NSManaged var title: String?

}
