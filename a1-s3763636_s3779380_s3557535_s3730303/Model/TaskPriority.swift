//
//  TaskPriority.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 19/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

enum TaskPriority {
    
    case none
    case low
    case medium
    case high
    
    var detail: (value:Int, colorCode:String) {
        switch self {
        case .none:
            return (4, "none")
        case .low:
            return (3, "#c9cba3")
        case .medium:
            return (2, "#ffe1a8")
        case .high:
            return (1, "#f08a7a")
        }
    }
    
}
