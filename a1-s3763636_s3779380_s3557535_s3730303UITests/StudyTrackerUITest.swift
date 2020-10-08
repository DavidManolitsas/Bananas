//
//  StudyTrackerUITest.swift
//  a1-s3763636_s3779380_s3557535_s3730303UITests
//
//  Created by kerwin on 7/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest

class StudyTrackerUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddRecords() {
        
        let alarmName = "test"
        
        let app = XCUIApplication()
        app.tabBars.buttons["Study Tracker"].tap()
        app.navigationBars["Study Tracker"].buttons["Item"].tap()
        
        let alarmTextField = app.textFields["Type alarm name"]
        XCTAssertTrue(alarmTextField.exists)
        alarmTextField.tap()
        alarmTextField.typeText(alarmName)
        
        app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let timerSlider = app.sliders["0%"]
        timerSlider.adjust(toNormalizedSliderPosition: 0.5)
        XCTAssertTrue(app.sliders["47%"].waitForExistence(timeout: 5))
        
        app.buttons["Start"].tap()
        XCTAssert(app.buttons["Stop"].exists)
        sleep(3)
        
        XCTAssertTrue(app.buttons["Stop"].waitForExistence(timeout: 5))
        app.buttons["Stop"].tap()
        XCTAssert(app.buttons["Start"].exists)
        
    }
    
    func testDeleteRecords() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Study Tracker"].tap()
        app.buttons["See previous study records"].tap()
        
        let recordsCell = app.tables.cells.containing(.staticText, identifier:"56 minutes of study")
        let titleField = recordsCell.staticTexts["test"]
        XCTAssertTrue(titleField.exists)
        
        recordsCell.staticTexts["0 minutes of break"].swipeLeft()
        let delete = recordsCell.buttons["Delete"]
        XCTAssertTrue(delete.waitForExistence(timeout: 5))
        delete.tap()
        
        
    }
    
}

