//
//  MoodTrackerDatabase.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 23/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct MoodTrackerDatabase {
    // dictionary - key: date, value: DailyRecord
    private var dailyRecords: [String:DailyRecord] = [:]
//    private var record: DailyRecord? = nil
    
    public mutating func addNewRecord(newRecord record: DailyRecord, forDate date: String) {
        dailyRecords.updateValue(record, forKey: date)
    }
    
    public func getRecord(forDate date: String) -> DailyRecord? {
        guard let record = dailyRecords[date] else {return nil }
        return record
    }
}
