//
//  TTRootViewControllerTests.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import XCTest
@testable import TTTask

class TTRootViewControllerTests: XCTestCase {
    
    var rootViewController:TTRootViewController!
    
    override func setUp() {
        super.setUp()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        rootViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ToDoStoryboardIdentifiers.Root.rawValue) as! TTRootViewController
        rootViewController.coreDataStack = TTCoreDataStack()
        // Nasty but forces view to load view ;)
        let _ = rootViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
        rootViewController = nil
    }
    
    func testFetchedResultsControllerCreation() {
        XCTAssertNotNil(rootViewController.fetchedResultsController)
    }
    
    func testSearchBarBeingAssignedAsTableViewHeader() {
        XCTAssertTrue(rootViewController.tableView.tableHeaderView === rootViewController.searchController.searchBar)
    }
    
    func testRootViewControllerDefinesPresentationContext() {
        XCTAssertTrue(rootViewController.definesPresentationContext)
    }
    
    func testRootViewTableViewBackgroundColor() {
        XCTAssertTrue(rootViewController.tableView.backgroundColor!.isEqual(TTTableViewBackgroundColor))
    }
    
    func testRootViewTableViewSeparatorInsets() {
        XCTAssertTrue(rootViewController.tableView.separatorInset == UIEdgeInsetsZero)
    }

}
