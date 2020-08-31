//
//  recordsModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by kerwin on 31/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct records{
    var breaktime: Int
    var title: String
    var timer: Int
    
    init(breaktime: Int, title: String, timer: Int){
        self.breaktime = breaktime
        self.title = title
        self.timer = timer
    }
    
    func getBreaktime() -> Int {
        return breaktime
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getTimer() -> Int{
        return timer
    }
}
