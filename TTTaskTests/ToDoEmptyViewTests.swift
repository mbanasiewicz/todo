//
//  ToDoEmptyViewTests.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 13/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import XCTest
@testable import TTTask

class ToDoEmptyViewTests: XCTestCase {
    func testLoadingFromNib() {
        XCTAssertNotNil(ToDoEmptyView.loadViewFromNib())
    }
    
    func testBackgroundColorBeingSet() {
        let emptyView = ToDoEmptyView.loadViewFromNib()!
        XCTAssertTrue(rgba(245.0, green: 245.0, blue: 245.0, alpha: 1.0).isEqual(emptyView.backgroundColor!))
    }
    
}
