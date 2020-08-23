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
    
    private var mood: Moods = Moods.none
    private var weather: Weather = Weather()
    private var notes: String = ""
    
    private mutating func addRecord(forDate date: String, forRecord record: DailyRecord) {
        moodTrackerDatabase.addNewRecord(newRecord: record, forDate: date)
    }
    
    public mutating func initMockRecords() {
        let record1 = DailyRecord(mood: Moods.great, weatherDetails: weather.getNextForecastDetails(), notes: "today was fab!")
        let record2 = DailyRecord(mood: Moods.awful, weatherDetails: weather.getNextForecastDetails(), notes: "today was awful!")
        let record3 = DailyRecord(mood: Moods.ok, weatherDetails: weather.getNextForecastDetails(), notes: "today was ok!")
        let record4 = DailyRecord(mood: Moods.good, weatherDetails: weather.getNextForecastDetails(), notes: "today was good!")
        let record5 = DailyRecord(mood: Moods.bad, weatherDetails: weather.getNextForecastDetails(), notes: "today was bad!")
        
        moodTrackerDatabase.addNewRecord(newRecord: record1, forDate: "23-08-20")
        moodTrackerDatabase.addNewRecord(newRecord: record2, forDate: "24-08-20")
        moodTrackerDatabase.addNewRecord(newRecord: record3, forDate: "22-08-20")
        moodTrackerDatabase.addNewRecord(newRecord: record4, forDate: "21-08-20")
        moodTrackerDatabase.addNewRecord(newRecord: record5, forDate: "20-08-20")
        
    }
    
    public mutating func createRecord(forDate date: String) {
        let record = DailyRecord(mood: self.mood, weatherDetails: getWeatherDetails(), notes: self.notes)
        addRecord(forDate: date, forRecord: record)
    }
    
    public mutating func getRecord(forDate date: String) -> DailyRecord {
        //guard
        guard let record = moodTrackerDatabase.getRecord(forDate: date)  else {
            let tuple = (iconName: "transparent", maxTemp: 0.00, minTemp: 0.00)
            return DailyRecord(mood: Moods.none, weatherDetails: tuple, notes: "Nothing stored yet") }
        return record
    }
    //  dailyRecord: init (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String) {
    
    
    public mutating func setMood(asMood moodStr: String) {
        for moodEnum in Moods.allCases {
            if moodStr == moodEnum.rawValue {
                self.mood = moodEnum
            }
        }
    }
    
    public mutating func getWeatherDetails() -> (iconName: String, maxTemp: Double, minTemp: Double) {
        //        var weatherDetails = weather.getNextForecastDetails()
        return weather.getNextForecastDetails()
    }
    
    public mutating func setNotes(text notes: String) {
        self.notes = notes
    }
}
