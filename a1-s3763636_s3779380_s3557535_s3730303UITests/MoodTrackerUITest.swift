//
//  MoodTrackerUITest.swift
//  a1-s3763636_s3779380_s3557535_s3730303UITests
//
//  Created by Jess Cui on 5/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest

class MoodTrackerUITest: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

//            let app = XCUIApplication()
            app.tabBars.buttons["Mood Tracker"].tap()
//            app.alerts["Allow “a1-s3763636_s3779380_s3557535_s3730303” to use your location?"].scrollViews.otherElements.buttons["Allow Once"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testNumComponents() {
//let app = XCUIApplication()
        let numBtns = app.buttons.count
        let numImgs = app.images.count
        XCTAssertEqual(numBtns, 9)
        XCTAssertEqual(numImgs, 2)
        
    }
    
    func testNotesTextValue() {
//        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        let notesElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Notes")
        notesElementsQuery.children(matching: .other).element(boundBy: 1).swipeUp()
        
        let textView = notesElementsQuery.children(matching: .textView).element
               textView.tap()
               sleep(2)
//        textView.value = "Hello UI Test"
        let value = textView.value as? String
        XCTAssertEqual(value, "Hello UI Test")
                
    }
    
    func testExample() {
     
//        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["greenbtn removebg preview"].tap()
        elementsQuery.buttons["orangebtn removebg preview"].tap()
        elementsQuery.buttons["lightgreenbtn removebg preview"].tap()
        elementsQuery.buttons["3"].tap()
        elementsQuery.buttons["redBtn removebg preview"].tap()
        
        
        
        
        
        
//        let notesElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Notes").element
//        notesElement.swipeUp()
//        notesElement.swipeUp()
//
//
//        notesElement.swipeDown()
//        scrollViewsQuery.otherElements.buttons["3"].swipeDown()
//        notesElementsQuery.children(matching: .other).element(boundBy: 0).swipeDown()
//        notesElement.swipeDown()
        
//        let element = notesElementsQuery.children(matching: .other).element(boundBy: 2)
//        element.swipeDown()
//        element.swipeUp()
//
//
//
//        let app = XCUIApplication()
//        app.tabBars.buttons["Mood Tracker"].tap()
//
//        let notesElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:"Notes")
//        notesElementsQuery.children(matching: .other).element(boundBy: 2).swipeUp()
//
//        let textView = notesElementsQuery.children(matching: .textView).element
//        textView.tap()
//        textView.tap()
                
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
