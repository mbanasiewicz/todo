//
//  TTTaskTests.swift
//  TTTaskTests
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import XCTest
@testable import TTTask

class TTCoreDataStackTests: XCTestCase {
    
    var coreDataStack:TTCoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TTCoreDataStack()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        coreDataStack = nil
    }
    
    func testManagedObjectContextCreation() {
        XCTAssertNotNil(coreDataStack.mainManagedObjectContext)
    }
}
