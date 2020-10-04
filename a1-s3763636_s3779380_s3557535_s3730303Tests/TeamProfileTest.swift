//
//  TeamProfileTest.swift
//  a1-s3763636_s3779380_s3557535_s3730303Tests
//
//  Created by Winnie Siwan on 4/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest
@testable import a1_s3763636_s3779380_s3557535_s3730303
class TeamProfileTest: XCTestCase {
    var teamProfile : TeamProfile = TeamProfile()
   
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPeopleIsValid() {
       XCTAssertNotNil(teamProfile.getPeople())
    }
    
    func testPeopleNames(){
        let people = teamProfile.getPeople()
        
        XCTAssertEqual(people[0].getProfileName(), "David Manolitsas")
        XCTAssertEqual(people[1].getProfileName(), "Jessica Cui")
        XCTAssertEqual(people[2].getProfileName(), "Peng Xiong")
        XCTAssertEqual(people[3].getProfileName(), "Winnie Siwan")
    }
    
    func testPeopleAvatar(){
        let people = teamProfile.getPeople()
        
        XCTAssertEqual(people[0].getAvatarName(), "dAvatar")
        XCTAssertEqual(people[1].getAvatarName(), "jAvatar")
        XCTAssertEqual(people[2].getAvatarName(), "kAvatar")
        XCTAssertEqual(people[3].getAvatarName(), "wAvatar")
    }
    
    func testFavRecipe(){
        let people = teamProfile.getPeople()
        
        XCTAssertEqual(people[0].getFavRecipe(), "Banana Bread")
        XCTAssertEqual(people[1].getFavRecipe(), "Banana Milkshake \nCinnamon cooked bananas on pancakes")
        XCTAssertEqual(people[2].getFavRecipe(), "Chocolate chip banana bar")
        XCTAssertEqual(people[3].getFavRecipe(), "Banana Ice Cream \nBanana Milkist")
    }
    
    
}
