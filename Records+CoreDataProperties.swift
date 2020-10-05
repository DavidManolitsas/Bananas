//
//  Records+CoreDataProperties.swift
//  
//
//  Created by kerwin on 1/10/20.
//
//

import Foundation
import CoreData


extension Records {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Records> {
        return NSFetchRequest<Records>(entityName: "Records")
    }

    @NSManaged public var breaktime: Int32
    @NSManaged public var timer: Int32
    @NSManaged public var title: String?

}
