//
//  TodoUITest.swift
//  a1-s3763636_s3779380_s3557535_s3730303UITests
//
//  Created by David Manolitsas on 8/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

import XCTest

class TodoUITest: XCTestCase {
    let app = XCUIApplication()

    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
        // Navigate to tab bars
        app.tabBars.buttons["To do"].tap()
    }
    
    func testAddingTasks() {
        app.buttons["Add"].tap()
        app.alerts.textFields["I want to..."].typeText("Go to the shops") // UIAlertController(title: "Add Task"
        app.buttons["Add"].tap()
        
        let numOfCells = app.tables.cells.count
        XCTAssertEqual(numOfCells, 1)
    }
    
    func testUIComponentsCount() {
        let buttonsCount = app.buttons.count
        let tableCount = app.tables.count
        XCTAssertEqual(buttonsCount, 6)
        XCTAssertEqual(tableCount, 1)
    }
    
}

