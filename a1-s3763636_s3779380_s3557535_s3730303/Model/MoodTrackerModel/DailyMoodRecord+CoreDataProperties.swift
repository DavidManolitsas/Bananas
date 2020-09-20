//
//  DailyMoodRecord+CoreDataProperties.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by Jess Cui on 20/9/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//
//

import Foundation
import CoreData


extension DailyMoodRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyMoodRecord> {
        return NSFetchRequest<DailyMoodRecord>(entityName: "DailyMoodRecord")
    }

    @NSManaged public var notes: String?
    @NSManaged public var mood: String?
    @NSManaged public var date: String?
    @NSManaged public var forecast: Forecast?

}
