//
//  TimerRecords.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Winnie Siwan on 15/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

class TimerRecords{
    var studyRecords = [records]()
    
    public func updateRecord(breakduration: Int, alarmName: String, durations: Int){
         studyRecords.insert(records(breaktime: breakduration, title: alarmName, timer: durations), at: 0)
    }
    
    
}
