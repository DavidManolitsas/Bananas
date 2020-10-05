//
//  TodoTask+CoreDataProperties.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 4/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var priority: Int64
    @NSManaged public var taskDescription: String?
    @NSManaged public var id: Int64

}
