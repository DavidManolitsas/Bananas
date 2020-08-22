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
    
    private var weather = Weather()
    private var dateStr: String = ""
    private var forecasts: [String:Forecast] = [:]
    
    public mutating func setDate(forDate date: String) {
        self.dateStr = date
    }
    
    public mutating func getImage() -> UIImage? {
        print(dateStr)
        guard let forecast = weather.getForecasts()[dateStr] else { return UIImage(named: "transparent")}
        let image = UIImage(named: forecast.getIconName())
        return image
    }
}


//
//    private var weather: Weather = Weather()
//    private var count: Int = 0
//    private var maxTemp: Double?
//    private var minTemp: Double?
//    private var iconName: String?
//
//    public mutating func setDate(forDate date: String) {
//        getForecast(forDate: date)
//    }
//
//    //todo: guard let optional
//    private mutating func getForecast(forDate date: String) {
//        var forecasts = weather.getForecasts()
////        maxTemp = (forecasts[date]?.getMaxTemp())!
////        minTemp = (forecasts[date]?.getMinTemp())!
////        iconName = (forecasts[date]?.getIconName())!
//
//    }
//
//    public func getMaxTemp() -> Double {
//        guard let max = maxTemp else {return 0}
//        return max
//    }
//
//    public func getMinTemp() -> Double {
//        guard let min = minTemp else {return 0}
//        return min
//    }
//
//    public func getImage() -> UIImage? {
//        guard let imageName = iconName else {
//            let blankImg = UIImage(named: "blank" )
//            return blankImg
//        }
//        let image = UIImage(named: imageName)
//        return image
//    }
