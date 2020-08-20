//
//  Task.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 19/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

class Task {
    
    var completed: Bool
    var description: String
    var priority: TaskPriority
    
//    var _priority: TaskPriority {
//        get {
//            return priority
//        }
//        set {
//            priority = newValue
//        }
//    }
    
    init(description: String) {
        self.description = description
        self.priority = .none
        self.completed = false;
    }
    
    
}
