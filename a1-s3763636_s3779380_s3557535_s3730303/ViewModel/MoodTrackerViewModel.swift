//
//  MoodTrackerViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 21/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import UIKit

struct MoodTrackerViewModel {
    //    private var moodTracker = MoodTracker()
    private var RESTReq = RESTRequest.shared
    //    private var currentIdx: Int = 0
    private var moodTrackerManager = MoodTrackerManager.shared
    private let celsius = "°C"
    private let dtFormat = "dd-MM-yy"
    
    private var model = RESTRequest.shared
    private var _mood: String
    private var _notes: String
    
    var delegate: Refresh? {
        get {
            return model.delegate
        }
        
        set (value) {
            model.delegate = value
        }
    }
    
    var notes: String {
        get {
            return _notes
        }
        
    }
    
    var mood: String {
        get {
            return _mood
        }
    }
    
    init() {
        self._mood = Moods.none.rawValue
        self._notes = ""
    }
    
    //    private mutating func initEmptyEntry() {
    //        self._mood = "None"
    //        self._notes = ""
    //    }
    var forecasts: [Forecast] {
        return model.forecasts
        
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = dtFormat;
        return formatter.string(from: date);
    }
    
    func getWeatherFor(_ lat: Double, _ lon: Double) {
        //        print("\(lat) and \(lon)")
        RESTReq.getWeatherFor(lat: String(lat), lon: String(lon))
    }
    
    var forecast: [Forecast] {
        return RESTReq.forecasts
    }
    
    //    private var dailyForecast = forecast[0]
    
    public func getImage() -> UIImage? {
        return UIImage(named: forecast[0].iconName)
    }
    
    public func getTempDetails() -> String {
        let maxInt = Int(round(forecast[0].maxTemp))
        
        let minInt = Int(forecast[0].minTemp)
        let maxTemp = String(maxInt) + celsius
        let minTemp = String(minInt) + celsius
        
        return "\(minTemp) - \(maxTemp)"
    }
    
    
    func addNotes(as notes: String, forDate date: Date) {
        print("adding notes for " + formatDate(date: date))
        moodTrackerManager.addNotes(notes,formatDate(date: date)) 
    }
    
    public func updateMoodFor(_ date: Date, as mood: Moods) {
        
        
        for moodEnum in Moods.allCases {
            if mood == moodEnum {
                let dateStr = formatDate(date: date)
                moodTrackerManager.addMood(moodEnum.rawValue, dateStr)
            }
            //                     if mood == moodEnum.rawValue {
            //                        let dateStr = formatDate(date: date)
            ////                        moodTrackerManager.addMood(moodEnum.rawValue, dateStr)
            //         //                moodTracker.updateMood(as: moodEnum, forDate: dateStr)
            //                     }
        }
        
    }
    
    
    func loadNotesFor(date: Date) -> String {
        let dt = formatDate(date: date)
        moodTrackerManager.retrieveRecordFor(date: dt)
        if let record = moodTrackerManager.record {
            print("there is a record for loading notes")
            let notes = record.notes!
            return notes
        }
        return ""
        
    }
    
    public mutating func loadRecordFor(_ date: Date) {
        let dt = formatDate(date: date)
        moodTrackerManager.retrieveRecordFor(date: dt)
        if let record = moodTrackerManager.record {
            self._notes = record.notes!
            self._mood = record.mood!
        } else {
            self._notes = ""
            self._mood = Moods.none.rawValue
        }
        
    }
    
    public mutating func getEventCountFor(_ date: Date) -> Int {
        loadRecordFor(date)
        var count = 0
        if _notes != "" { count += 1 }
        if _mood != Moods.none.rawValue { count += 1 }
        
        return count
    }
    
    // check if there is a mood or note entry for a given date
    //    public mutating func getRecordEvent(forDate date: Date) -> Int{
    //        let record = moodTracker.getRecord(forDate: formatDate(date: date))
    //        var count = 0
    //
    //        if record.getMood() != Moods.none { count += 1 }
    //        if record.getNotes() != "" { count += 1 }
    //
    //        return count
    //    }
    //
    //    public mutating func updateMood(forDate date: Date, as mood: String) {
    //        let dateStr = formatDate(date: date)
    //
    //        for moodEnum in Moods.allCases {
    //            if mood == moodEnum.rawValue {
    ////                moodTracker.updateMood(as: moodEnum, forDate: dateStr)
    //            }
    //        }
    //
    //    }
    //
    //    public mutating func updateNotes(forDate date: Date, as notes: String) {
    //        let dateStr = formatDate(date: date)
    //        moodTracker.updateNotes(as: notes, forDate: dateStr)
    //    }
    
    //    public mutating func getMood(forDate date: Date) -> String {
    //        let record = moodTracker.getRecord(forDate: formatDate(date: date))
    //        return record.getMood().rawValue
    //    }
    //
    //    public mutating func getNotes(forDate date: Date) -> String {
    //        let record = moodTracker.getRecord(forDate: formatDate(date: date))
    //        return record.getNotes()
    //    }
    //
    //    public mutating func getWeatherDetails(forDate date: Date) -> (uiImage: UIImage?, maxTemp: String, minTemp: String) {
    //        let record = moodTracker.getRecord(forDate: formatDate(date: date))
    //        let details = record.getWeatherDetails()
    //        let image = UIImage(named: details.iconName)
    //
    //        let maxInt = Int(round(details.maxTemp))
    //        let minInt = Int(round(details.minTemp))
    //        let maxTemp = String(maxInt) + celsius
    //        let minTemp = String(minInt) + celsius
    //
    //        return (image, maxTemp, minTemp)
    //    }
    
    
}
