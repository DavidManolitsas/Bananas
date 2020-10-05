//
//  TestSongList.swift
//  a1-s3763636_s3779380_s3557535_s3730303Tests
//
//  Created by Winnie Siwan on 5/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import XCTest
@testable import a1_s3763636_s3779380_s3557535_s3730303
class SongListTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSongListMatches(){
        let songList = getSongList()
        XCTAssertEqual(songList[0], "1")
        XCTAssertEqual(songList[1], "2")
        XCTAssertEqual(songList[2], "3")
        
    }
  
}
