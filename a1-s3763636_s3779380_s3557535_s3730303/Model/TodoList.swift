//
//  Tasks.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 26/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TodoList {
    
    private var tasks:[Task]
    
    init() {
        tasks = [Task]()
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
    
    
    func setTaskReminder(currTask: Task, isOn: Bool) {
        for task in tasks {
            if task.description == currTask.description {
                task.reminderOn = isOn
                print("reminder is on: \(task.reminderOn)")
            }
        }
    }
    
    
    func setTaskPriority(searchedTask: Task, priority: TaskPriority) {
        
        for i in 0..<tasks.count {
            if searchedTask === tasks[i] {
                tasks[i].priority = priority
            }
        }
        
    }
    
    mutating func removeTask(at: Int) {
        tasks.remove(at: at)
    }
    
    
    
    public mutating func getTasks() -> [Task] {
        return tasks
    }
    
}
