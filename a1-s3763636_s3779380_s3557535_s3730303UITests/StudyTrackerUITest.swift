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
       
        continueAfterFailure = false
        
       
        XCUIApplication().launch()
        
      
    }
    
    override func tearDown() {
      
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
        
        XCTAssertTrue(app.buttons["Stop"].waitForExistence(timeout: 5))
        app.buttons["Stop"].tap()
        
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

