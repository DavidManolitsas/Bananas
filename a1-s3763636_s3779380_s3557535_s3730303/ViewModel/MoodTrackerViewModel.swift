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
    
    // transforming the data
    public mutating func getNextImg() -> UIImage? {
        let image = UIImage(named: weather.getNextForecast().getIconName())
        return image
    }
    
    
}
