//
//  TTSearchResultsViewController.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit
import CoreData

class TTSearchResultsViewController: UITableViewController, UISearchResultsUpdating {
    
    var coreDataStack:TTCoreDataStack
    
    var searchResults:[Todo]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: View controller lifecycle
    
    init(coreDataStack:TTCoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.backgroundColor = TTTableViewBackgroundColor
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.registerNib(UINib(nibName: TTToDoTableViewCellRI, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: TTToDoTableViewCellRI)
    }
    
    // MARK: UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let query = searchController.searchBar.text
        guard query != nil else { return }
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query!)
        do {
            searchResults = try coreDataStack.mainManagedObjectContext.executeFetchRequest(fetchRequest) as? [Todo]
        } catch {
            presentErrorAlert("Unable to perform search")
            searchResults = nil
        }
    }
    
    // MARK: Table view
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TTToDoTableViewCellRI) as! TTToDoTableViewCell
        let toDo = searchResults![indexPath.row]
        cell.configureWithToDo(toDo)
        return cell
    }
}
