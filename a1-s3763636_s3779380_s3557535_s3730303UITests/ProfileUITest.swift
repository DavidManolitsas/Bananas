//
//  ProfileUITest.swift
//  a1-s3763636_s3779380_s3557535_s3730303UITests
//
//  Created by Winnie Siwan on 3/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest

class ProfileUITest: XCTestCase {
    
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
    
    
    
    func testProfileElementExists() {
        let app = XCUIApplication()
        app.tabBars.buttons["Profiles"].tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element

        XCTAssertTrue(app.images["dAvatar"].exists)
        XCTAssertTrue(app.staticTexts["displayName"].exists)
        XCTAssertTrue(app.textViews["favRecipe"].exists)
        
        // change page
        textView.swipeLeft()
        
        XCTAssertTrue(app.images["jAvatar"].exists)
        XCTAssertTrue(app.staticTexts["displayName"].exists)
        XCTAssertTrue(app.textViews["favRecipe"].exists)
        
        //change page
        textView.swipeLeft()
        
        XCTAssertTrue(app.images["kAvatar"].exists)
        XCTAssertTrue(app.staticTexts["displayName"].exists)
        XCTAssertTrue(app.textViews["favRecipe"].exists)
        
        //change page
        textView.swipeLeft()
        
        XCTAssertTrue(app.images["wAvatar"].exists)
        XCTAssertTrue(app.staticTexts["displayName"].exists)
        XCTAssertTrue(app.textViews["favRecipe"].exists)
        
    }
    
    func testProfileNames(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Profiles"].tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["displayName"]/*[[".staticTexts[\"David Manolitsas\"]",".staticTexts[\"displayName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        
        XCTAssertEqual(app.staticTexts["displayName"].label, "David Manolitsas")
        
        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.staticTexts["displayName"].label, "Jessica Cui")
        
        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.staticTexts["displayName"].label, "Peng Xiong")
        
        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.staticTexts["displayName"].label, "Winnie Siwan")
        
    }
    
    func testProfileRecipe(){
        let app = XCUIApplication()
        app.tabBars.buttons["Profiles"].tap()

        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element


        XCTAssertEqual(app.textViews["favRecipe"].value as! String,"Banana Bread")

        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.textViews["favRecipe"].value as! String,"Banana Milkshake \nCinnamon cooked bananas on pancakes")

        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.textViews["favRecipe"].value as! String,"Chocolate chip banana bar")

        //change page
        textView.swipeLeft()
        XCTAssertEqual(app.textViews["favRecipe"].value as! String,"Banana Ice Cream \nBanana Milkist")
        
    }
    
    func testProfileImage(){
        let app = XCUIApplication()
        app.tabBars.buttons["Profiles"].tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        
        var myImage = XCUIApplication().images["dAvatar"]
        var screenshotBefore = myImage.screenshot()
        
        textView.swipeLeft()
        myImage = XCUIApplication().images["jAvatar"]
        var screenshotAfter = myImage.screenshot()
        
        // make sure the profile avatar is different
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
        // update the previous screenshot as the 2nd profile screenshot
        screenshotBefore = screenshotAfter
        
        
        textView.swipeLeft()
        myImage = XCUIApplication().images["kAvatar"]
        screenshotAfter = myImage.screenshot()
        // make sure the profile avatar is different
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
        // update the previous screenshot as the 2nd profile screenshot
        screenshotBefore = screenshotAfter
        
        textView.swipeLeft()
        myImage = XCUIApplication().images["wAvatar"]
        screenshotAfter = myImage.screenshot()
        // make sure the profile avatar is different
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
        
    }
    
}
