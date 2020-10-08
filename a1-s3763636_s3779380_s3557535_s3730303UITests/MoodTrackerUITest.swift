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
        continueAfterFailure = false
        app.launch()
        app.tabBars.buttons["Mood Tracker"].tap()
        
/**
 if this is the first time launching, there may be a pop up where you need to allow location
 */
            // app.alerts["Allow “a1-s3763636_s3779380_s3557535_s3730303” to use your location?"].scrollViews.otherElements.buttons["Allow Once"].tap()

    }
  
    func testNumComponents() {
        let numBtns = app.buttons.count
        let numImgs = app.images.count
        XCTAssertEqual(numBtns, 9)
        XCTAssertEqual(numImgs, 2)
        
    }
    
    // When a different date is selected, test if the weather labels will change
    func testWeatherLabelChange() {
        let calendar = app.otherElements["fsCalendar"].children(matching: .other).element.children(matching: .other).element(boundBy: 3).collectionViews
        let date = calendar.children(matching: .cell).element(boundBy: 8).staticTexts["5"]
        date.swipeRight()

        calendar.children(matching: .cell).element(boundBy: 29).staticTexts["28"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        let dateLblText = elementsQuery.staticTexts["28 September, 2020"].label
        let locationLbl = elementsQuery.staticTexts["Mock location"].label
        let tempLbl = elementsQuery.staticTexts["30°C - 50°C"].label
        let feelsLikeLbl = elementsQuery.staticTexts["102°C"].label
        let sunriseLbl = elementsQuery.staticTexts["5:43 am"].label
        let sunsetLbl = elementsQuery.staticTexts["6:01pm"].label

        XCTAssertEqual(dateLblText, "28 September, 2020")
        XCTAssertEqual(locationLbl, "Mock location")
        XCTAssertEqual(tempLbl, "30°C - 50°C")
        XCTAssertEqual(feelsLikeLbl, "102°C")
        XCTAssertEqual(sunriseLbl, "5:43 am")
        XCTAssertEqual(sunsetLbl, "6:01pm")
        
        // select a different date
        calendar.children(matching: .cell).element(boundBy: 11).staticTexts["10"].tap()
        
        let dateLblText2 = elementsQuery.staticTexts["10 September, 2020"].label
         let locationLbl2 = elementsQuery.staticTexts["Desert"].label
        let tempLbl2 = elementsQuery.staticTexts["40°C - 60°C"].label
         let feelsLikeLbl2 = elementsQuery.staticTexts["32°C"].label
         let sunriseLbl2 = elementsQuery.staticTexts["9:00 am"].label
        let sunsetLbl2 = elementsQuery.staticTexts["7:01pm"].label
        
        XCTAssertEqual(dateLblText2, "10 September, 2020")
        XCTAssertEqual(locationLbl2, "Desert")
        XCTAssertEqual(tempLbl2, "40°C - 60°C")
        XCTAssertEqual(feelsLikeLbl2, "32°C")
        XCTAssertEqual(sunriseLbl2, "9:00 am")
        XCTAssertEqual(sunsetLbl2, "7:01pm")
    }
    
    func testNotesEntry() {
        let calendar = app.otherElements["fsCalendar"].children(matching: .other).element.children(matching: .other).element(boundBy: 3).collectionViews
        let date = calendar.children(matching: .cell).element(boundBy: 8).staticTexts["5"]
        date.swipeRight()

        // tap on 28th
        calendar.children(matching: .cell).element(boundBy: 29).staticTexts["28"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let notesElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Notes")
        notesElementsQuery.children(matching: .other).element(boundBy: 0).swipeUp()
    
        let textView = notesElementsQuery.children(matching: .textView).element
        let textValue = textView.value as? String
        XCTAssertEqual(textValue, "Wow it's boiling hot today")
        
        // tap on 11th
        calendar.children(matching: .cell).element(boundBy: 11).staticTexts["10"].tap()
        let textValue2 = textView.value as? String
        XCTAssertEqual(textValue2, "Humans weren't built to survive 60 degrees... I don't feel so good...")
    }
    
}
