//
//  Forecast+CoreDataProperties.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 20/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var iconName: String?
    @NSManaged public var maxTemp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var dailyMoodRecord: DailyMoodRecord?

}
