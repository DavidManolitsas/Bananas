//  Weather.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 21/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct Forecast {
    private var main: String, description: String, iconName: String, maxTemp: Double, minTemp: Double
    
    init(main: String, description: String, iconName: String, maxTemp: Double, minTemp: Double) {
        self.main = main
        self.description = description
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.iconName = iconName
        
    }
    
    func getIconName() -> String {
        return iconName
    }
}

func populateMockObjects() -> [Forecast] {
    var mockForecasts: [Forecast] = []
    let clouds = Forecast(main: "Clouds", description: "scattered clouds", iconName: "03d", maxTemp: 12.14, minTemp: 7.12)
    let clouds2 = Forecast(main: "Clouds", description: "broken clouds", iconName: "04d", maxTemp: 15.14, minTemp: 8.12)
    let clear = Forecast(main: "Clear", description: "clear sky", iconName: "01d", maxTemp: 14.82, minTemp: 10.03)
    let rain = Forecast(main: "Rain", description: "moderate rain", iconName: "10d", maxTemp: 11.93, minTemp: 6.32)
    let thunder = Forecast(main: "Thunder", description: "thunder storms", iconName: "11d", maxTemp: 10.93, minTemp: 8.73)
    
    mockForecasts.append(contentsOf: [clouds, clouds2, clear, rain, thunder])
    
    return mockForecasts
}




//print(mockForecasts)
//print(mockForecasts[3].getIconName())
