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
    private (set) var notes: String = ""
    
    private mutating func addRecord(forDate date: String, forRecord record: DailyRecord) {
        moodTrackerDatabase.addNewRecord(newRecord: record, forDate: date)
    }
    
    public func getRecord(forDate date: String) -> DailyRecord? {
//        guard let
        return moodTrackerDatabase.getRecord(forDate: date)
    }
    //  dailyRecord: init (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String) {
    public mutating func createRecord(forDate date: String) {
        let record = DailyRecord(mood: self.mood, weatherDetails: getWeatherDetails(), notes: self.notes)
        addRecord(forDate: date, forRecord: record)
    }
    
    public mutating func setMood(moodStr: String) {
        for moodEnum in Moods.allCases {
            if moodStr == moodEnum.rawValue {
                self.mood = moodEnum
            }
        }
    }
    
    private mutating func getWeatherDetails() -> (iconName: String, maxTemp: Double, minTemp: Double) {
        //        var weatherDetails = weather.getNextForecastDetails()
        return weather.getNextForecastDetails()
    }
    
    public mutating func setNotes(text notes: String) {
        self.notes = notes
    }
}
