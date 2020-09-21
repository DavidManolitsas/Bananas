//
//  MoodTracker.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 23/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct MoodTracker {
    
    private var moodTrackerDatabase = MoodTrackerDatabase()
//    private var weather: Weather = Weather()
    
    private mutating func updateRecord(forDate date: String, forRecord record: DailyRecord) {
        moodTrackerDatabase.updateRecord(for: record, forDate: date)
    }
    
//    public mutating func initMockRecords() {
//        let record1 = DailyRecord(mood: Moods.great, weatherDetails: weather.getNextForecastDetails(), notes: "today was fab!")
//        let record2 = DailyRecord(mood: Moods.awful, weatherDetails: weather.getNextForecastDetails(), notes: "today was awful!")
//        let record3 = DailyRecord(mood: Moods.ok, weatherDetails: weather.getNextForecastDetails(), notes: "today was ok!")
//        let record4 = DailyRecord(mood: Moods.good, weatherDetails: weather.getNextForecastDetails(), notes: "today was good!")
//        let record5 = DailyRecord(mood: Moods.bad, weatherDetails: weather.getNextForecastDetails(), notes: "today was bad!")
//
//        moodTrackerDatabase.updateRecord(for: record1, forDate: "23-08-20")
//        moodTrackerDatabase.updateRecord(for: record2, forDate: "24-08-20")
//        moodTrackerDatabase.updateRecord(for: record3, forDate: "22-08-20")
//        moodTrackerDatabase.updateRecord(for: record4, forDate: "21-08-20")
//        moodTrackerDatabase.updateRecord(for: record5, forDate: "20-08-20")
//
//    }
    
//    public mutating func createRecord(forDate date: String) {
//        let record = DailyRecord(mood: Moods.none, weatherDetails: getWeatherDetails(), notes: "")
//        updateRecord(forDate: date, forRecord: record)
//    }
    
    public mutating func getRecord(forDate date: String) -> DailyRecord {
        guard let record = moodTrackerDatabase.getRecord(forDate: date)  else {
            let tuple = (iconName: "transparent", maxTemp: 0.00, minTemp: 0.00)
            return DailyRecord(mood: Moods.none, weatherDetails: tuple, notes: "") }
        return record
    }
    
//    public mutating func updateMood(as newMood: Moods, forDate date: String) {
//        if var record = moodTrackerDatabase.getRecord(forDate: date) {
//            record.updateMood(as: newMood)
//            moodTrackerDatabase.updateRecord(for: record, forDate: date)
//
//        } else {
//            let newRecord = DailyRecord(mood: newMood, weatherDetails: getWeatherDetails(), notes: "")
//            moodTrackerDatabase.updateRecord(for: newRecord, forDate: date)
//        }
//    }
    
//    public mutating func getWeatherDetails() -> (iconName: String, maxTemp: Double, minTemp: Double) {
//        return weather.getNextForecastDetails()
//    }

    
//    public mutating func updateNotes(as notes: String, forDate date: String) {
//        if var record = moodTrackerDatabase.getRecord(forDate: date) {
//            record.updateNotes(as: notes)
//            moodTrackerDatabase.updateRecord(for: record, forDate: date)
//        } else {
//            let newRecord = DailyRecord(mood: Moods.none, weatherDetails: getWeatherDetails(), notes: notes)
//            moodTrackerDatabase.updateRecord(for: newRecord, forDate: date)
//        }
//        
//    }
}
