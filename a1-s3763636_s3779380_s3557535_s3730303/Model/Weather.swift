//
//  Weather.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 21/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct Weather {
    private var forecasts: [Forecast] = []
    private var currentIdx: Int = 0
    
    init() {
        initForecasts()
        
    }
    
    private mutating func initForecasts()  {
        let clouds = Forecast(main: "Clouds", description: "scattered clouds", iconName: "03d", maxTemp: 12.14, minTemp: 7.12)
        let clouds2 = Forecast(main: "Clouds", description: "broken clouds", iconName: "04d", maxTemp: 15.14, minTemp: 8.12)
        let clear = Forecast(main: "Clear", description: "clear sky", iconName: "01d", maxTemp: 14.82, minTemp: 10.03)
        let rain = Forecast(main: "Rain", description: "moderate rain", iconName: "10d", maxTemp: 11.93, minTemp: 6.32)
        let thunder = Forecast(main: "Thunder", description: "thunder storms", iconName: "11d", maxTemp: 10.93, minTemp: 8.73)
        
        forecasts.append(contentsOf: [clouds, clouds2, clear, rain, thunder])
    }
    
    public mutating func getNextForecastDetails() -> (iconName: String, maxTemp: Double, minTemp: Double) {
        // basically looping through the image names array
        if currentIdx == 4 {currentIdx = 0}
        else { currentIdx += 1 }
        
        return (forecasts[currentIdx].getIconName(), forecasts[currentIdx].getMaxTemp(), forecasts[currentIdx].getMinTemp())
    }
    
//    public mutating func getForecastDetails() -> (iconName: String, maxTemp: Double, minTemp: Double) {
//        let forecast = getNextForecast()
//
//        return (forecast.getIconName(), forecast.getMaxTemp(), forecast.getMinTemp())
//    }
    
    public func getIconName(atIndex currentIdx: Int) -> String {
        return forecasts[currentIdx].getIconName()
    }
    
    public func getMaxTemp(atIndex currentIdx: Int) -> Double {
        return forecasts[currentIdx].getMaxTemp()
    }
    
    public func getMinTemp(atIndex currentIdx: Int) -> Double {
        return forecasts[currentIdx].getMinTemp()
    }
}
