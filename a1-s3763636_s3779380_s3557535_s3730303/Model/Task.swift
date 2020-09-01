//
//  Task.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 19/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

class Task {
    
    private var _completed: Bool
    private var _reminderOn: Bool
    private var _description: String
    private var _priority: TaskPriority
    
    init(description: String) {
        self._description = description
        self._priority = .none
        self._completed = false;
        self._reminderOn = false;
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
    
    var description: String {
        get {
            return _description
        }
        set (newDescription) {
            _description = newDescription
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
    
}
