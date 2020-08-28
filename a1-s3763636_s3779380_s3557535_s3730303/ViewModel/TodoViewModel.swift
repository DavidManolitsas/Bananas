//
//  TodoViewModel.swift
//  a1-s3763636_s3779380_s3557535_s3730303
//
//  Created by David Manolitsas on 26/8/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation

struct TodoViewModel {
    
    private var _todoList = TodoList()
    
    var todoList:TodoList {
        get {
            return _todoList
        }
        set {
            _todoList = newValue
        }
    }
    
    
    public mutating func setTaskReminder(currTask: Task, isOn: Bool) {
        for task in todoList.tasks {
            if task === currTask {
                task.reminderOn = isOn
                todoList.updateTask(updatedTask: task)
                print("reminder is on: \(task.reminderOn)")
                break
            }
        }
    }
    
    
    public mutating func setTaskPriority(searchedTask: Task, priority: TaskPriority) {
        for task in todoList.tasks {
            if searchedTask === task {
                task.priority = priority
                todoList.updateTask(updatedTask: task)
                break
            }
        }
        
    }

}

//    func sortTasks(tasks: [Task]) -> [Task] {
//
//        var sortedTasks:[Task] = tasks
//
//        //Bubble Sort
//        for i in 0..<sortedTasks.count {
//            for j in 1..<sortedTasks.count - i {
//                if sortedTasks[j].getTaskPriorityValue() < sortedTasks[j-1].getTaskPriorityValue() {
//                    let temp = sortedTasks[j-1]
//                    sortedTasks[j-1] = sortedTasks[j]
//                    sortedTasks[j] = temp
//                }
//            }
//        }
//        return sortedTasks
//
//    }
    
    
    

