//
//  CalendarRecord.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 23/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation


// things to store
// date
// weather
// mood - if applicable
// notes - if applicable

// DailyRecord (weather, mood, note objects)
struct DailyRecord {
    private var mood: Moods = Moods.none
    private var weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double)? = nil
    private var notes: String = ""
    
//    private var record: (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String)?

    init (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String) {
        self.mood = mood
        self.weatherDetails = weatherDetails
        self.notes = notes
    }
    
    public mutating func getRecord() ->  (mood: Moods, weatherDetails: (iconName: String, maxTemp: Double, minTemp: Double), notes: String)? {
        
        guard let details = weatherDetails else { return nil }
        return (mood, details, notes)
    }
    
//    
}
