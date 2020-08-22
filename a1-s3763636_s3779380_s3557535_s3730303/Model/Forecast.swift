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
    
    public func getIconName() -> String {
        return iconName
    }
    
    public func getMaxTemp() -> Double {
        return maxTemp
    }
    
    public func getMinTemp() -> Double {
        return minTemp
    }
}






