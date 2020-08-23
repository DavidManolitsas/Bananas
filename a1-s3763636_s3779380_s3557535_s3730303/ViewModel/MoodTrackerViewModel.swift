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
    // reference to the model object
    private var weather = Weather()
//    private var dailyRecord = DailyRecord()
//    private var moodTrackerDatabase = MoodTrackerDatabase()
    private var moodTracker = MoodTracker()
    
    //    private var details: (iconName: String, maxTemp: Double, minTemp: Double) = ("01d", 15.32, 6.04)
    private var currentIdx: Int = 0
    
    private var iconName: String = "01d"
    private var maxTemp: Double = 13.42
    private var minTemp: Double = 7.32
    private let celsius = "°C"
    
    public mutating func getWeatherDetails() -> (uiImage: UIImage?, maxTemp: String, minTemp: String) {
        let details = weather.getNextForecastDetails()
        
        let image = UIImage(named: details.iconName)
        let maxTemp = String(details.maxTemp) + celsius
        let minTemp = String(details.minTemp) + celsius
        
        return (image, maxTemp, minTemp)
        
    }
    
    
//    public func updateRecords(forDate date: String) {
//        moodTrackerDatabase.addNewRecord(newRecord: <#T##DailyRecord#>, forDate: <#T##String#>)
//    }
    
    
}
