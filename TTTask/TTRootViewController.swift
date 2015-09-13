//
//  TTRootViewController.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit
import CoreData

class TTRootViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var coreDataStack:TTCoreDataStack?
    
    var fetchedResultsController:NSFetchedResultsController?
    
    lazy var searchController:UISearchController = {
        let searchResultsViewController = TTSearchResultsViewController(coreDataStack: self.coreDataStack!)
        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchResultsUpdater = searchResultsViewController
        searchController.searchBar.barTintColor = TTBarTintColor
        searchController.searchBar.tintColor = TTOrange
        return searchController
    }()
    
    // MARK: View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(coreDataStack != nil)
        createFetchedRequestsController()
        configureTableView()
        definesPresentationContext = true
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            presentErrorAlert("Unable to load ToDo's")
        }
        
        updateEmptyStateViewVisibility()
    }
    
    // MARK: Utilities
    func updateEmptyStateViewVisibility() {
        if let objectsCount = fetchedResultsController?.fetchedObjects?.count {
            if objectsCount > 0 {
                tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                tableView.backgroundView = nil
            } else {
                tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                tableView.backgroundView = ToDoEmptyView.loadViewFromNib()
            }
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = TTTableViewBackgroundColor
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.tableHeaderView = searchController.searchBar
        tableView.registerNib(UINib(nibName: TTToDoTableViewCellRI, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: TTToDoTableViewCellRI)
    }
    
    func createFetchedRequestsController() {
        let fetchRequest = NSFetchRequest(entityName: Todo.entityName())
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 50
        let moc = coreDataStack!.mainManagedObjectContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
    }
    
    // MARK: Actions
    @IBAction func presentAddToDoViewController() {
        let addEntryViewController = storyboard!.instantiateViewControllerWithIdentifier(ToDoStoryboardIdentifiers.AddNewEntry.rawValue) as! TTAddNewToDoViewController
        addEntryViewController.coreDataStack = coreDataStack
        presentViewController(UINavigationController(rootViewController: addEntryViewController), animated: true, completion: nil)
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
        updateEmptyStateViewVisibility()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == .Insert {
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Right)
        }
        
        if type == .Delete {
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Left)
        }
        
        if type == .Update {
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    // MARK: Table view delegate
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let markAsCompletedAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Mark as completed") { [weak self] (action, indexPath) -> Void in
            guard self != nil else { return }
            if let toDo = self!.fetchedResultsController?.objectAtIndexPath(indexPath) as? Todo {
                toDo.completed = true
                if toDo.hasChanges {
                    do {
                        try toDo.managedObjectContext?.save()
                    } catch {
                        self!.presentErrorAlert("Unable to update ToDo")
                    }
                }
            }
        }
        markAsCompletedAction.backgroundColor = UIColor.greenColor()
        
        let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { [weak self] (action, indexPath) -> Void in
            guard self != nil else { return }
            if let toDo = self!.fetchedResultsController?.objectAtIndexPath(indexPath) as? Todo {
                self!.coreDataStack?.mainManagedObjectContext.deleteObject(toDo)
                do {
                    try toDo.managedObjectContext?.save()
                } catch {
                    self!.presentErrorAlert("Unable to delete ToDo")
                }
            }
        }
        
        return [markAsCompletedAction, deleteAction]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var toDos = fetchedResultsController?.fetchedObjects as? [Todo]
        guard toDos != nil else { return }
        
        let itemToMove = toDos![sourceIndexPath.row]
        toDos!.removeAtIndex(sourceIndexPath.row)
        toDos!.insert(itemToMove, atIndex: destinationIndexPath.row)
        for (idx, item) in toDos!.enumerate().reverse() {
            item.order = idx
        }
        coreDataStack?.saveContext()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TTToDoTableViewCellRI) as! TTToDoTableViewCell
        if let toDo = fetchedResultsController?.objectAtIndexPath(indexPath) as? Todo {
            cell.configureWithToDo(toDo)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = ToDoDetailViewController(toDo: fetchedResultsController!.objectAtIndexPath(indexPath) as! Todo)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
