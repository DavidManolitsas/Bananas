//
//  CalendarRecord.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 23/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct DailyRecord {
    private var mood: Moods = Moods.none
    private var weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double) = (iconName: "transparent", maxTemp: 0.00, minTemp: 0.00)
    private var notes: String = ""

    init (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String) {
        self.mood = mood
        self.weatherDetails = weatherDetails
        self.notes = notes
    }
    
    public func getMood() -> Moods {
        return mood
    }
    
    public func getNotes() -> String {
        return notes
    }
    
    public mutating func updateMood(as mood: Moods) {
        self.mood = mood
    }
    
    public mutating func updateNotes(as notes: String) {
        self.notes = notes
    }
    
    public func getWeatherDetails() ->  (iconName: String, maxTemp: Double, minTemp: Double) {
        return weatherDetails

    }
}
