//
//  RestoUITests.swift
//  RestoUITests
//
//  Created by David Gomez on 10/11/2022.
//

import XCTest

class RestoUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() async throws {
        app = XCUIApplication()
        app.launchArguments = ["-uiTest"]
    }
    
    func testLoadRestaurants() throws {
        // UI tests must launch the application that they test.
        // Mock response filename
        app.launchEnvironment = ["FILENAME":"RestaurantsMock"]
        app.launch()
        
        let tableView = app.tables.containing(.table, identifier: "TableViewIdentifier")
        XCTAssertTrue(tableView.cells.count > 0)
        XCTAssertTrue(tableView.cells.count == 10)
    }
}
