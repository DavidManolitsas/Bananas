//
//  TimerViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 15/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

struct TimerViewModel {
    
    
    private var trackerManager = RecordsManager.tracker
    
    public mutating func updateRecords(_ breaktime:Int,_ timer:Int,_ title: String){
        trackerManager.addRecords(breaktime: breaktime, timer: timer, title: title)
    }
   
}
