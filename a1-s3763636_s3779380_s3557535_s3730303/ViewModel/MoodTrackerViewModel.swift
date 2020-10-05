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
    private var RESTReq = RESTRequest.shared
    private var moodTrackerManager = MoodTrackerManager.shared
    private let celsius = "°C"
    private let dtFormat = "dd-MM-yy"
    
    private var _mood: String
    private var _notes: String
    private var _tempDetails: String
    private var _location: String
    private var locationOffIcon: String
    private var locationOnIcon: String
    private var weatherIcon: String
    private var _sunriseTime: String
    private var _sunsetTime: String
    private var _feelsLike: String
    
    var delegate: Refresh? {
        get {
            return RESTReq.delegate
        }
        
        set (value) {
            RESTReq.delegate = value
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
    
    var location: String {
        get {
            return _location
        }
    }
    
    var feelsLike: String {
        get {
            return _feelsLike
        }
    }
    
    var sunriseTime: String {
        get {
            return _sunriseTime
        }
    }
    
    var sunsetTime: String {
        get {
            return _sunsetTime
        }
    }
    
    var tempDetails: String {
        get {
            return _tempDetails
        }
    }
    
    var locationOffImg: UIImage? {
        get {
            return UIImage(named: locationOffIcon)
        }
    }
    
    var locationOnImg: UIImage? {
        get {
            return UIImage(named: locationOnIcon)
        }
    }
    
    var weatherImg: UIImage? {
        get {
            return UIImage(named: weatherIcon)
        }
    }
    
    init() {
        self._mood = Moods.none.rawValue
        self._notes = ""
        self._tempDetails = "No weather"
        self._location = "No location"
        self.locationOffIcon = "location_off"
        self.locationOnIcon = "location"
        self.weatherIcon = "transparent"
        self._sunsetTime = "No data"
        self._sunriseTime = "No data"
        self._feelsLike = "No data"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = dtFormat;
        return formatter.string(from: date);
    }
    
    public func getWeatherFor(_ lat: Double, _ lon: Double) {
        RESTReq.getWeatherFor(lat: String(lat), lon: String(lon))
    }
    
    public func getImage() -> UIImage? {
        if let forecast = RESTReq.forecast {
            return UIImage(named: forecast.iconName)
        }
        return UIImage(named: self.weatherIcon)
    }
    
    public func getTodayTempDetails() -> String {
        if let forecast = RESTReq.forecast {
            return formatTempDetails(forecast.minTemp, forecast.maxTemp)
        }
        return self._tempDetails
    }
    
    public mutating func getSunriseTime() -> String {
        if let forecast = RESTReq.forecast {
            self._sunriseTime = formatTime(utc: forecast.sunrise)
            return self._sunriseTime
        }
        return "No data"
    }
    
    public mutating func getSunsetTime() -> String {
        if let forecast = RESTReq.forecast {
            self._sunsetTime = formatTime(utc: forecast.sunset)
            return self._sunsetTime
        }
        return "No data"
    }
    
    private func formatTime(utc: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(utc))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: date)
        return localDate
        
    }
    
    public mutating func getFeelsLikeTemp()-> String {
        if let forecast = RESTReq.forecast {
            let temp = formatFeelsLikeTemp(forecast.feelsLike)
            
            return temp
        }
        return "No data"
        
    }
    
    private func formatFeelsLikeTemp(_ feelsLike: Double) -> String {
        let temp = Int(round(feelsLike))
        return String(temp) + celsius
    }
    
    public func updateWeatherDetailsFor(_ today: Date) {
        if let forecast = RESTReq.forecast {
           moodTrackerManager.updateWeatherDetails(formatDate(today), forecast.minTemp, forecast.maxTemp, forecast.iconName, forecast.feelsLike, self._sunriseTime, self._sunsetTime)
            
//            moodTrackerManager.updateWeatherDetails("09-09-20", forecast.minTemp, forecast.maxTemp, forecast.iconName, forecast.feelsLike, self.sunriseTime, self.sunsetTime)
        }
        
    }
    
    public func updateNotesFor(_ date: Date, as notes: String) {
        moodTrackerManager.updateNotes(notes, formatDate(date))
    }
    
    public func updateMoodFor(_ date: Date, as mood: Moods) {
        for moodEnum in Moods.allCases {
            if mood == moodEnum {
                let dateStr = formatDate(date)
                moodTrackerManager.updateMood(moodEnum.rawValue, dateStr)
            }
        }
        
    }
    
    public func updateWeatherForLocation(_ location: String, _ date: Date) {
        moodTrackerManager.updateWeatherLocation(location, formatDate(date))
//                moodTrackerManager.updateWeatherLocation(location, "09-09-20")
    }
    
    public mutating func loadRecordFor(_ date: Date) {
        let dt = formatDate(date)
        moodTrackerManager.retrieveRecordFor(date: dt)
        
        if let record = moodTrackerManager.record {
            
            self._notes = record.notes!
            self._mood = record.mood!
            
            if let weather = record.weather {
                self._tempDetails = formatTempDetails(weather.minTemp, weather.maxTemp)
                self._location = weather.location
                self.weatherIcon = weather.iconName
                self._feelsLike = formatFeelsLikeTemp(weather.feelsLike)
                self._sunriseTime = weather.sunriseTime
                self._sunsetTime = weather.sunsetTime
//                print("the sunset time is \(weather.sunsetTime)")
            }
            
        } else {
            // reset to empty view
            self._notes = ""
            self._mood = Moods.none.rawValue
            self._tempDetails = "No weather"
            self._location = "No location"
            self.weatherIcon = "transparent"
            self._feelsLike = "No data"
            self._sunriseTime = "No data"
            self._sunsetTime = "No data"
        }
        
    }
    
    public func formatTempDetails(_ min: Double,_ max: Double) -> String {
        let minInt = Int(round(min))
        let maxInt = Int(round(max))
        let minTemp = String(minInt) + celsius
        let maxTemp = String(maxInt) + celsius
        
        return "\(minTemp) - \(maxTemp)"
    }
    
    public mutating func getEventCountFor(_ date: Date) -> Int {
        loadRecordFor(date)
        var count = 0
        if _notes != "" { count += 1 }
        if _mood != Moods.none.rawValue { count += 1 }
        
        return count
    }
    
}
