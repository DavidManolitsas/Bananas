//
//  Weather+CoreDataProperties.swift
//  
//
//  Created by Jess Cui on 30/9/20.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var feelsLike: Double
    @NSManaged public var iconName: String
    @NSManaged public var location: String
    @NSManaged public var maxTemp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var sunriseTime: String
    @NSManaged public var sunsetTime: String
    @NSManaged public var dailyMoodRecord: DailyMoodRecord?

}
