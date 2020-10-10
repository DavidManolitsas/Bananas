//
//  Task.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 19/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

class Task {
    
    private let _id:Int
    private var _completed: Bool
    private var _reminderOn: Bool
    private var _description: String
    private var _priority: TaskPriority
    private var _reminder: ReminderDate
    
    init(id:Int, description: String) {
        _id = id
        _description = description
        _priority = .none
        _completed = false
        _reminderOn = false
        _reminder = ReminderDate()
    }
    
    
    func getTaskPriorityValue() -> Int {
        if completed {
            return 5
        } else if priority == TaskPriority.none {
            return 4
        } else if priority == TaskPriority.low {
            return 3
        } else if priority == TaskPriority.medium {
            return 2
        } else if priority == TaskPriority.high {
            return 1
        }
        
        return -1
    }
    
    
    func getInt64Priority () -> Int64 {
        if priority == TaskPriority.none {
            return Int64(4)
        } else if priority == TaskPriority.low {
            return Int64(3)
        } else if priority == TaskPriority.medium {
            return Int64(2)
        } else if priority == TaskPriority.high {
            return Int64(1)
        }
        
        return Int64(-1)
    }
    
    func setPriorityFromNS(priorityValue: Int) {
        switch priorityValue {
        case 1:
            _priority = .high
        case 2:
            _priority = .medium
        case 3:
            _priority = .low
        case 4:
            _priority = .none
        default:
            print("Invalid priority value")
        }
    }
    
    
    var description: String {
        get {
            return _description
        }
        set (newDescription) {
            _description = newDescription
        }
    }
    
    var id: Int {
        get {
            return _id
        }
    }
    
    var priority: TaskPriority {
        get {
            return _priority
        }
        set (newPriority) {
            _priority = newPriority
        }
    }
    
    var completed: Bool {
        get {
            return _completed
        }
        set (newCompleted) {
            _completed = newCompleted
        }
    }
    
    var reminderOn: Bool {
        get {
            return _reminderOn
        }
        set (newReminderOn) {
            _reminderOn = newReminderOn
        }
    }
    
    
    var reminder: ReminderDate {
        get {
            return _reminder
        }
        set (newReminder) {
            _reminder = newReminder
        }
    }
}
