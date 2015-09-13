//
//  Todo.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import Foundation
import CoreData

class Todo: NSManagedObject {
    
    class func entityName() -> String {
        return "Todo"
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        updateDefaultValues()
    }
    
    private func updateDefaultValues() {
        createdAt = NSDate()
        let fetchRequest = NSFetchRequest(entityName: self.dynamicType.entityName())
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        fetchRequest.fetchLimit = 1
        do {
            if let result = try self.managedObjectContext!.executeFetchRequest(fetchRequest).first as? Todo {
                if let maxOrder = result.order {
                    order = maxOrder.integerValue + 1
                }
            }
        } catch {
            print("Error \(error), omg!")
        }
    }
    
    class func createInContext(managedObjectContext:NSManagedObjectContext, title:String, notes:String) -> Todo {
        let description = NSEntityDescription.entityForName("Todo", inManagedObjectContext: managedObjectContext)!
        let newEntity = Todo(entity: description, insertIntoManagedObjectContext: managedObjectContext)
        newEntity.title = title
        newEntity.notes = notes
        return newEntity
    }
    
}
