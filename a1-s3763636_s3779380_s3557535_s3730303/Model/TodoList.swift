//
//  Tasks.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 26/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TodoList {
    
    private var _tasks:[Task]
    
    var tasks:[Task] {
        get {
            return _tasks
        }
        set (newTasks) {
            _tasks = newTasks
        }
    
    }
    
    
    init() {
        _tasks = [Task]()
    }
    
    
    public mutating func sortTasks() {
        //Bubble Sort
        for i in 0..<self.tasks.count {
            for j in 1..<tasks.count - i {
                if tasks[j].getTaskPriorityValue() < tasks[j-1].getTaskPriorityValue() {
                    let temp = tasks[j-1]
                    tasks[j-1] = tasks[j]
                    tasks[j] = temp
                }
            }
        }
        
    }
    

    public mutating func addTask(insertedTask: Task) {
        let index:Int = 0
        tasks.insert(insertedTask, at: index)
    }
    
    
    mutating func updateTask(updatedTask: Task) {
        for i in 0..<tasks.count {
            if updatedTask === tasks[i] {
                tasks[i] = updatedTask
            }
        }
    }
    
    mutating func removeTask(at: Int) {
        tasks.remove(at: at)
    }
    
}
