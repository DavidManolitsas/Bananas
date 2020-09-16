//
//  TimerViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 15/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TimerViewModel {
//    var studyRecords = [records]()
    var timerRecords = TimerRecords()
    
    public mutating func updateRecord(breakduration: Int, alarmName: String, durations: Int){
       timerRecords.updateRecord(breakduration: breakduration, alarmName: alarmName, durations: durations)
    }
    public func getRecordsFromModel() -> [records]{
        return timerRecords.getRecordsDetails()
    }
    
}
